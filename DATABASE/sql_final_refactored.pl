#!/usr/bin/env perl

=head1 NAME

sql_final_refactored.pl - Process tab-delimited bioinformatics data files and populate sequence library database

=head1 SYNOPSIS

    perl sql_final_refactored.pl <input_file>

=head1 DESCRIPTION

This script processes tab-delimited data files containing bioinformatics experiment
metadata and populates the SequencesDB database with structured library information.
It handles complex data relationships including:

=over 4

=item * Organism, tissue, cell, and experiment metadata

=item * Sequencing method and antibody information

=item * Repeat/replicate numbering and read type classification

=item * Library and file associations

=item * Paired-end read relationships

=back

The script uses a sophisticated lookup-or-create pattern to avoid duplicate entries
and maintains referential integrity through database transactions.

=head1 REQUIRED ARGUMENTS

=over 4

=item input_file

Path to tab-delimited input file with header row starting with '#'. 
Required columns include:

=over 4

=item * Organism - Species name (e.g., "Homo sapiens")

=item * Tissue - Tissue type (e.g., "Brain")

=item * Cell - Cell type (e.g., "Neurons")

=item * Experiment - Experiment description

=item * Background - Background/control description

=item * Method - Experimental method used

=item * Antibody - Antibody name (optional)

=item * Sequencer - Sequencing platform

=item * Repeat - Repeat information (e.g., "repeat1", "replicate2")

=item * Library - Library identifier/filename

=item * Read Type - Read type classification (e.g., "paired-end-1")

=back

=back

=head1 DEPENDENCIES

=over 4

=item * DBI - Database interface

=item * Config::Tiny - Configuration file parsing

=item * File::Basename - File path manipulation

=item * Carp - Error handling

=item * Log::Log4perl - Structured logging

=item * MySQL/MariaDB database with SequencesDB schema

=item * ../config/database.conf - Database configuration

=item * ../config/log4perl.conf - Logging configuration

=back

=head1 EXIT STATUS

=over 4

=item 0 - Success

=item 1 - Error (file parsing, database operations, or transaction failure)

=back

=head1 EXAMPLES

    # Process experiment metadata file
    perl sql_final_refactored.pl /data/experiment_metadata.txt

    # Example input file format:
    #Organism	Tissue	Cell	Experiment	Repeat	Library
    Human	Brain	Neuron	RNA-seq	repeat1	lib001
    Mouse	Liver	Hepatocyte	ChIP-seq	replicate2	lib002

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=head1 SEE ALSO

file_path_refactored.pl, SequencesDB web application

=cut

use strict;
use warnings;
use DBI;
use Config::Tiny;
use File::Basename;
use Carp;
use Log::Log4perl;

# Initialize logging
my $log4perl_config = dirname(__FILE__) . '/../config/log4perl.conf';
Log::Log4perl->init($log4perl_config);
my $logger = Log::Log4perl->get_logger('SequencesDB.Scripts');

# Load configuration
my $config_file = dirname(__FILE__) . '/../config/database.conf';
my $config = Config::Tiny->read($config_file) 
    or croak "Cannot read config file: $config_file";

$logger->info("Starting sql_final_refactored.pl script");
$logger->debug("Using config file: $config_file");

my $db_config = $config->{database};
my $dbh = DBI->connect(
    $db_config->{dsn}, 
    $db_config->{user}, 
    $db_config->{password},
    { RaiseError => 1, AutoCommit => 1 }
) or croak "Connection Error: $DBI::errstr";

sub get_or_create_id {
    my ($dbh, $table, $column, $value) = @_;
    
    return undef unless defined $value && $value ne '';
    
    my $id_column = lc($table) . "_id";
    
    my $select_sql = "SELECT $id_column FROM $table WHERE $column = ?";
    my $sth = $dbh->prepare($select_sql);
    $sth->execute($value);
    
    if (my $row = $sth->fetchrow_hashref) {
        return $row->{$id_column};
    } else {
        my $insert_sql = "INSERT INTO $table ($column) VALUES (?)";
        $sth = $dbh->prepare($insert_sql);
        $sth->execute($value);
        # Use mysql_insertid for MariaDB/MySQL
        return $dbh->{mysql_insertid};
    }
}

sub parse_repeat_info {
    my ($repeat_string) = @_;
    return {} unless $repeat_string;
    
    if ($repeat_string =~ m/^(.*?)(\d+)$/i) {
        my ($type, $number) = (lc($1), $2);
        
        if ($type =~ m/^repeat/) {
            return { repeat_id => $number };
        } elsif ($type =~ m/^replicate/) {
            return { replicate_id => $number };
        } elsif ($type =~ m/^technical/) {
            return { repeat_id => 1 };
        }
    }
    return {};
}

sub parse_file_data {
    my ($filename) = @_;
    
    open my $fh, '<', $filename 
        or croak "Cannot open file $filename: $!";
    
    my (@data, @headers);
    
    while (my $line = <$fh>) {
        chomp $line;
        next if $line =~ /^\s*$/;
        
        if ($line =~ m/^#/) {
            @headers = split "\t", $line;
            s/^#// for @headers;
            next;
        }
        
        my @values = split "\t", $line;
        my %record;
        
        for my $i (0 .. $#headers) {
            $record{$headers[$i]} = $values[$i] if defined $values[$i] && $values[$i] ne '';
        }
        
        push @data, \%record;
    }
    
    close $fh;
    return \@data;
}

sub process_library_data {
    my ($data) = @_;
    
    my $id1;
    my $id2;
    
    $dbh->begin_work;
    
    eval {
        for my $record (@$data) {
            my $lookup_ids = {
                organism_id   => get_or_create_id($dbh, 'Organism', 'organism_name', $record->{Organism}),
                tissue_id     => get_or_create_id($dbh, 'Tissue', 'tissue_name', $record->{Tissue}),
                cell_id       => get_or_create_id($dbh, 'Cell', 'cell_name', $record->{Cell}),
                experiment_id => get_or_create_id($dbh, 'Experiment', 'experiment_name', $record->{Experiment}),
                background_id => get_or_create_id($dbh, 'Background', 'background_name', $record->{Background}),
                method_id     => get_or_create_id($dbh, 'Method', 'method_name', $record->{Method}),
                antibody_id   => get_or_create_id($dbh, 'Antibody', 'antibody_name', $record->{Antibody}),
                sequencer_id  => get_or_create_id($dbh, 'Sequencer', 'sequencer_name', $record->{Sequencer}),
            };
            
            my $repeat_info = parse_repeat_info($record->{Repeat});
            
            my @columns = ();
            my @values = ();
            
            for my $field (keys %$lookup_ids) {
                if (defined $lookup_ids->{$field}) {
                    # CORRECTION IS HERE: Correctly formats the foreign key column names
                    my ($prefix) = $field =~ /(.+)_id/;
                    push @columns, "${prefix}_${prefix}_id";
                    push @values, $lookup_ids->{$field};
                }
            }
            
            for my $field (keys %$repeat_info) {
                push @columns, $field;
                push @values, $repeat_info->{$field};
            }
            
            my $placeholders = join(',', ('?') x @values);
            my $library_sql = "INSERT INTO Library (" . join(',', @columns) . ") VALUES ($placeholders)";
            my $sth = $dbh->prepare($library_sql);
            $sth->execute(@values);
            my $library_id = $dbh->{mysql_insertid};
            
            if ($record->{'Read Type'}) {
                if ($record->{'Read Type'} =~ m/^paired.*1/i) {
                    $id1 = $library_id;
                } elsif ($record->{'Read Type'} =~ m/^paired.*2/i) {
                    $id2 = $library_id;
                }
                
                if (defined $id1 && defined $id2) {
                    my $read_type_sql = "INSERT INTO Read_Type (library_library_id, library_library_id1) VALUES (?, ?)";
                    $sth = $dbh->prepare($read_type_sql);
                    $sth->execute($id1, $id2);
                    $id1 = undef;
                    $id2 = undef;
                }
            }
            
            if ($record->{Library}) {
                my $file_sql = "INSERT INTO File (library_library_id, file_name) VALUES (?, ?)";
                $sth = $dbh->prepare($file_sql);
                $sth->execute($library_id, $record->{Library});
            }
        }
        
        $dbh->commit;
        $logger->info("Successfully processed " . scalar(@$data) . " records");
    };
    
    if ($@) {
        $dbh->rollback;
        $logger->error("Transaction failed: $@");
        croak "Transaction failed: $@";
    }
}

my $input_file = shift @ARGV 
    or croak "Usage: $0 <input_file>";

my $data = parse_file_data($input_file);
process_library_data($data);

$dbh->disconnect;
$logger->info("Script completed successfully");