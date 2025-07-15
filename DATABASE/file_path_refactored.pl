#!/usr/bin/env perl

=head1 NAME

file_path_refactored.pl - Process SHA2 hash files and update sequence library database

=head1 SYNOPSIS

    perl file_path_refactored.pl <sha2_file>

=head1 DESCRIPTION

This script processes SHA2 hash files containing file paths and checksums for bioinformatics
sequence data. It updates the SequencesDB database by:

=over 4

=item * Parsing SHA2 hash files with 64-character hex hashes and file paths

=item * Creating new library records for unique SHA2 hashes

=item * Updating existing library records with file path information

=item * Managing file records and their associations with libraries

=item * Maintaining data integrity through secure database operations

=back

The script uses structured logging via Log4perl and secure database operations with
prepared statements to prevent SQL injection vulnerabilities.

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

$logger->info("Starting file_path_refactored.pl script");
$logger->debug("Using config file: $config_file");

my $db_config = $config->{database};
# CORRECTION: Changed AutoCommit to 1 to prevent transaction errors.
my $dbh = DBI->connect(
    $db_config->{dsn}, 
    $db_config->{user}, 
    $db_config->{password},
    { RaiseError => 1, AutoCommit => 1 } 
) or croak "Connection Error: $DBI::errstr";


sub parse_sha2_file {
    my ($filename) = @_;
    
    open my $fh, '<', $filename 
        or croak "Cannot open file $filename: $!";
    
    my %sha2_data;
    my %file_data;
    
    while (my $line = <$fh>) {
        chomp $line;
        
        if ($line =~ m/^([0-9a-fA-F]{64})\s+(.+)$/) {
            my ($sha2, $full_path) = ($1, $2);
            
            my $file_name = fileparse($full_path);
            my $file_path = dirname($full_path);
            
            push @{$sha2_data{$sha2}{$file_name}}, $file_path;
            
            $file_data{$file_name} = {
                sha2 => $sha2,
                paths => ($file_data{$file_name}{paths} || [])
            };
            push @{$file_data{$file_name}{paths}}, $file_path;
        }
    }
    
    close $fh;
    return (\%sha2_data, \%file_data);
}


sub update_library_sha2 {
    my ($file_data) = @_;
    
    my $update_sql = "UPDATE Library, File 
                     SET Library.sha2 = ? 
                     WHERE Library.library_id = File.library_library_id 
                     AND File.file_name = ?";
    
    my $sth = $dbh->prepare($update_sql);
    
    for my $file_name (sort keys %$file_data) {
        $sth->execute($file_data->{$file_name}{sha2}, $file_name);
    }
    
    $logger->info("Updated SHA2 keys for " . scalar(keys %$file_data) . " files");
}

sub sha2_exists {
    my ($sha2) = @_;
    
    my $select_sql = "SELECT library_id FROM Library WHERE sha2 = ?";
    my $sth = $dbh->prepare($select_sql);
    $sth->execute($sha2);
    
    return $sth->fetchrow_hashref;
}


sub create_library_with_sha2 {
    my ($sha2) = @_;
    
    my $insert_sql = "INSERT INTO Library (sha2) VALUES (?)";
    my $sth = $dbh->prepare($insert_sql);
    $sth->execute($sha2);
    
    return $dbh->{mysql_insertid};
}

sub insert_file_record {
    my ($file_name, $file_path, $library_id) = @_;
    
    my $insert_sql = "INSERT INTO File (file_name, file_path, library_library_id) VALUES (?, ?, ?)";
    my $sth = $dbh->prepare($insert_sql);
    $sth->execute($file_name, $file_path, $library_id);
}

sub file_path_exists {
    my ($file_path, $library_id) = @_;
    
    my $select_sql = "SELECT file_id FROM File WHERE file_path = ? AND library_library_id = ?";
    my $sth = $dbh->prepare($select_sql);
    $sth->execute($file_path, $library_id);
    
    return $sth->fetchrow_hashref;
}

sub update_file_path {
    my ($file_path, $library_id, $file_name) = @_;
    
    my $update_sql = "UPDATE File 
                     SET file_path = ? 
                     WHERE library_library_id = ? 
                     AND file_name = ?";
    
    my $sth = $dbh->prepare($update_sql);
    $sth->execute($file_path, $library_id, $file_name);
}

sub find_null_path_files {
    my ($library_id) = @_;
    
    my $select_sql = "SELECT file_id FROM File WHERE file_path IS NULL AND library_library_id = ?";
    my $sth = $dbh->prepare($select_sql);
    $sth->execute($library_id);
    
    return $sth->fetchall_arrayref({});
}

sub get_library_file_info {
    my ($sha2, $file_name) = @_;
    
    my $select_sql = "SELECT l.library_id, f.file_id, f.library_library_id 
                     FROM Library l
                     INNER JOIN File f ON l.library_id = f.library_library_id
                     WHERE l.sha2 = ? AND f.file_name = ?";
    
    my $sth = $dbh->prepare($select_sql);
    $sth->execute($sha2, $file_name);
    
    return $sth->fetchrow_hashref;
}

sub process_sha2_data {
    my ($sha2_data) = @_;
    
    for my $sha2 (sort keys %$sha2_data) {
        my $existing_library = sha2_exists($sha2);
        
        if (!$existing_library) {
            my $library_id = create_library_with_sha2($sha2);
            $logger->info("Created new library (ID: $library_id) for SHA2: $sha2");
            
            for my $file_name (sort keys %{$sha2_data->{$sha2}}) {
                for my $file_path (@{$sha2_data->{$sha2}{$file_name}}) {
                    insert_file_record($file_name, $file_path, $library_id);
                }
            }
        } else {
            my $library_id = $existing_library->{library_id};
            $logger->info("Updating existing library (ID: $library_id) for SHA2: $sha2");
            
            for my $file_name (sort keys %{$sha2_data->{$sha2}}) {
                for my $file_path (@{$sha2_data->{$sha2}{$file_name}}) {
                    if (!file_path_exists($file_path, $library_id)) {
                        my $null_files = find_null_path_files($library_id);
                        
                        if (@$null_files) {
                            update_file_path($file_path, $library_id, $file_name);
                            $logger->info("Updated file path for $file_name in library $library_id");
                        } else {
                            insert_file_record($file_name, $file_path, $library_id);
                            $logger->info("Inserted new file record for $file_name in library $library_id");
                        }
                    }
                }
            }
        }
    }
}


sub process_sha2_file {
    my ($input_file) = @_;
    
    eval {
        my ($sha2_data, $file_data) = parse_sha2_file($input_file);
        
        update_library_sha2($file_data);
        
        process_sha2_data($sha2_data);
        
        $logger->info("Successfully processed SHA2 file: $input_file");
    };
    
    if ($@) {
        $logger->error("Processing failed: $@");
        croak "Processing failed: $@";
    }
}


my $input_file = shift @ARGV 
    or croak "Usage: $0 <sha2_file>";

process_sha2_file($input_file);
$dbh->disconnect;
$logger->info("Script completed successfully");