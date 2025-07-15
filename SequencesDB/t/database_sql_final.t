#!/usr/bin/env perl

=head1 NAME

database_sql_final.t - Unit tests for DATABASE/sql_final_refactored.pl functions

=head1 DESCRIPTION

This test suite provides comprehensive unit testing for the functions in the
sql_final_refactored.pl script. It tests the experimental metadata processing
functions that handle tab-delimited bioinformatics data files.

=head2 Tested Functions

=over 4

=item * get_or_create_id - Lookup-or-create pattern for entity management

=item * parse_repeat_info - Repeat/replicate information parsing

=item * parse_file_data - Tab-delimited file parsing

=item * process_library_data - Main data processing workflow

=back

=head2 Test Strategy

=over 4

=item * Mock Objects - Database and logging mocks for isolation

=item * Unit Testing - Individual function behavior verification

=item * Error Handling - Exception and error condition testing

=item * Data Validation - Input/output data structure verification

=back

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=head1 SEE ALSO

L<sql_final_refactored.pl>, L<Test::More>, L<Test::Mock::Guard>

=cut

use strict;
use warnings;
use Test::More;
use Test::Mock::Guard;
use FindBin qw($Bin);
use lib "$Bin/../../DATABASE";

# Mock DBI and Log4perl to avoid actual database connections and logging
my $mock_dbh = Test::Mock::Guard->new(
    'DBI' => {
        'connect' => sub { return MockDBH->new(); },
    }
);

my $mock_log4perl = Test::Mock::Guard->new(
    'Log::Log4perl' => {
        'init' => sub { return 1; },
        'get_logger' => sub { return MockLogger->new(); },
    }
);

# Load the script functions
require_ok('sql_final_refactored.pl');

# Test get_or_create_id function
subtest 'get_or_create_id' => sub {
    my $mock_dbh = MockDBH->new();
    
    # Test with existing ID
    $mock_dbh->{fetchrow_result} = { organism_id => 123 };
    my $result = get_or_create_id($mock_dbh, 'Organism', 'organism_name', 'Human');
    is($result, 123, 'get_or_create_id returns existing ID when record exists');
    
    # Test with non-existing ID (should create new)
    $mock_dbh->{fetchrow_result} = undef;
    $mock_dbh->{last_insert_id_result} = 456;
    $result = get_or_create_id($mock_dbh, 'Organism', 'organism_name', 'Mouse');
    is($result, 456, 'get_or_create_id creates and returns new ID when record does not exist');
    
    # Test with undefined value
    $result = get_or_create_id($mock_dbh, 'Organism', 'organism_name', undef);
    is($result, undef, 'get_or_create_id returns undef for undefined value');
    
    # Test with empty string
    $result = get_or_create_id($mock_dbh, 'Organism', 'organism_name', '');
    is($result, undef, 'get_or_create_id returns undef for empty string');
};

# Test parse_repeat_info function
subtest 'parse_repeat_info' => sub {
    # Test repeat parsing
    my $result = parse_repeat_info('repeat3');
    is_deeply($result, { repeat_id => 3 }, 'parse_repeat_info correctly parses repeat');
    
    # Test replicate parsing
    $result = parse_repeat_info('replicate2');
    is_deeply($result, { replicate_id => 2 }, 'parse_repeat_info correctly parses replicate');
    
    # Test technical parsing
    $result = parse_repeat_info('technical1');
    is_deeply($result, { repeat_id => 1 }, 'parse_repeat_info correctly parses technical');
    
    # Test invalid format
    $result = parse_repeat_info('invalid_format');
    is_deeply($result, {}, 'parse_repeat_info returns empty hash for invalid format');
    
    # Test undefined input
    $result = parse_repeat_info(undef);
    is_deeply($result, {}, 'parse_repeat_info returns empty hash for undefined input');
};

# Test parse_file_data function
subtest 'parse_file_data' => sub {
    # Create a temporary test file
    my $test_file = '/tmp/test_data.txt';
    open my $fh, '>', $test_file or die "Cannot create test file: $!";
    print $fh "#Organism\tTissue\tCell\tExperiment\tRepeat\tLibrary\n";
    print $fh "Human\tBrain\tNeuron\tRNA-seq\trepeat1\tlib001\n";
    print $fh "Mouse\tLiver\tHepatocyte\tChIP-seq\treplicate2\tlib002\n";
    print $fh "\n";  # Empty line should be skipped
    print $fh "Rat\tKidney\tTubule\tATAC-seq\ttechnical1\tlib003\n";
    close $fh;
    
    my $data = parse_file_data($test_file);
    
    # Test data structure
    is(scalar @$data, 3, 'parse_file_data returns correct number of records');
    
    # Test first record
    is($data->[0]{Organism}, 'Human', 'First record organism correct');
    is($data->[0]{Tissue}, 'Brain', 'First record tissue correct');
    is($data->[0]{Cell}, 'Neuron', 'First record cell correct');
    is($data->[0]{Experiment}, 'RNA-seq', 'First record experiment correct');
    is($data->[0]{Repeat}, 'repeat1', 'First record repeat correct');
    is($data->[0]{Library}, 'lib001', 'First record library correct');
    
    # Test second record
    is($data->[1]{Organism}, 'Mouse', 'Second record organism correct');
    is($data->[1]{Repeat}, 'replicate2', 'Second record repeat correct');
    
    # Test third record
    is($data->[2]{Organism}, 'Rat', 'Third record organism correct');
    is($data->[2]{Repeat}, 'technical1', 'Third record repeat correct');
    
    # Cleanup
    unlink $test_file;
};

# Test process_library_data function
subtest 'process_library_data' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    my $test_data = [
        {
            Organism => 'Human',
            Tissue => 'Brain',
            Cell => 'Neuron',
            Experiment => 'RNA-seq',
            Background => 'Control',
            Method => 'Standard',
            Antibody => 'Anti-H3K4me3',
            Sequencer => 'Illumina',
            Repeat => 'repeat1',
            Library => 'lib001',
            'Read Type' => 'paired-end-1'
        }
    ];
    
    # Mock return values for get_or_create_id calls
    $mock_dbh->{fetchrow_result} = undef;  # No existing records
    $mock_dbh->{last_insert_id_result} = 100;  # New library ID
    
    lives_ok { process_library_data($test_data) } 'process_library_data executes without error';
    
    ok($mock_dbh->{prepare_called}, 'Database prepare() was called');
    ok($mock_dbh->{execute_called}, 'Database execute() was called');
    ok($mock_dbh->{begin_work_called}, 'Transaction begin_work() was called');
    ok($mock_dbh->{commit_called}, 'Transaction commit() was called');
};

# Test error handling in process_library_data
subtest 'process_library_data_error_handling' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    # Force an error by making execute fail
    $mock_dbh->{should_fail} = 1;
    
    my $test_data = [
        {
            Organism => 'Human',
            Tissue => 'Brain',
            Cell => 'Neuron',
            Experiment => 'RNA-seq',
            Repeat => 'repeat1',
            Library => 'lib001'
        }
    ];
    
    dies_ok { process_library_data($test_data) } 'process_library_data dies on database error';
    
    ok($mock_dbh->{rollback_called}, 'Transaction rollback() was called on error');
};

# Test paired-end read handling
subtest 'paired_end_read_handling' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    my $test_data = [
        {
            Organism => 'Human',
            Tissue => 'Brain',
            Cell => 'Neuron',
            Experiment => 'RNA-seq',
            Repeat => 'repeat1',
            Library => 'lib001',
            'Read Type' => 'paired-end-1'
        },
        {
            Organism => 'Human',
            Tissue => 'Brain',
            Cell => 'Neuron',
            Experiment => 'RNA-seq',
            Repeat => 'repeat1',
            Library => 'lib002',
            'Read Type' => 'paired-end-2'
        }
    ];
    
    $mock_dbh->{fetchrow_result} = undef;
    $mock_dbh->{last_insert_id_result} = 100;
    
    lives_ok { process_library_data($test_data) } 'process_library_data handles paired-end reads correctly';
    
    # Should have extra insert for Read_Type table
    ok($mock_dbh->{prepare_called}, 'Database prepare() was called');
    ok($mock_dbh->{execute_called}, 'Database execute() was called');
};

done_testing();

# Mock classes for testing
package MockDBH;
sub new { 
    my $class = shift;
    return bless {
        prepare_called => 0,
        execute_called => 0,
        last_insert_id_called => 0,
        begin_work_called => 0,
        commit_called => 0,
        rollback_called => 0,
        fetchrow_result => undef,
        last_insert_id_result => undef,
        should_fail => 0,
    }, $class;
}

sub prepare { 
    my $self = shift;
    $self->{prepare_called} = 1;
    return MockSTH->new($self);
}

sub last_insert_id { 
    my $self = shift;
    $self->{last_insert_id_called} = 1;
    return $self->{last_insert_id_result};
}

sub begin_work { 
    my $self = shift;
    $self->{begin_work_called} = 1;
    return 1;
}

sub commit { 
    my $self = shift;
    $self->{commit_called} = 1;
    return 1;
}

sub rollback { 
    my $self = shift;
    $self->{rollback_called} = 1;
    return 1;
}

sub disconnect { return 1; }

package MockSTH;
sub new { 
    my ($class, $dbh) = @_;
    return bless { dbh => $dbh }, $class;
}

sub execute { 
    my $self = shift;
    $self->{dbh}{execute_called} = 1;
    
    if ($self->{dbh}{should_fail}) {
        die "Mocked database error";
    }
    
    return 1;
}

sub fetchrow_hashref { 
    my $self = shift;
    return $self->{dbh}{fetchrow_result};
}

package MockLogger;
sub new { return bless {}, shift; }
sub info { return 1; }
sub debug { return 1; }
sub warn { return 1; }
sub error { return 1; }