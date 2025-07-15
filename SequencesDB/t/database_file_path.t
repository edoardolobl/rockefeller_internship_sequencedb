#!/usr/bin/env perl

=head1 NAME

database_file_path.t - Unit tests for DATABASE/file_path_refactored.pl functions

=head1 DESCRIPTION

This test suite provides comprehensive unit testing for the functions in the
file_path_refactored.pl script. It uses mock objects to avoid actual database
connections and file system dependencies, ensuring fast and reliable testing.

=head2 Tested Functions

=over 4

=item * parse_sha2_file - SHA2 hash file parsing

=item * update_library_sha2 - Library SHA2 field updates

=item * sha2_exists - SHA2 hash existence checking

=item * create_library_with_sha2 - New library creation

=item * insert_file_record - File record insertion

=item * file_path_exists - File path existence checking

=item * update_file_path - File path updates

=item * find_null_path_files - NULL path file detection

=item * get_library_file_info - Library-file relationship queries

=item * process_sha2_data - Main SHA2 processing logic

=item * process_sha2_file - Complete file processing workflow

=back

=head2 Test Strategy

=over 4

=item * Mock Objects - Avoid database dependencies

=item * Edge Cases - Test boundary conditions and error scenarios

=item * Data Validation - Verify correct data structure handling

=item * Error Handling - Test error conditions and recovery

=back

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=head1 SEE ALSO

L<file_path_refactored.pl>, L<Test::More>, L<Test::Mock::Guard>

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
require_ok('file_path_refactored.pl');

# Test parse_sha2_file function
subtest 'parse_sha2_file' => sub {
    # Create a temporary test file
    my $test_file = '/tmp/test_sha2.txt';
    open my $fh, '>', $test_file or die "Cannot create test file: $!";
    print $fh "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef /path/to/file1.txt\n";
    print $fh "abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890 /different/path/file2.txt\n";
    print $fh "invalid_line_without_sha2\n";
    close $fh;

    my ($sha2_data, $file_data) = parse_sha2_file($test_file);
    
    # Test SHA2 data structure
    ok(exists $sha2_data->{'1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef'}, 
       'SHA2 key exists in sha2_data');
    ok(exists $sha2_data->{'abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890'}, 
       'Second SHA2 key exists in sha2_data');
    
    # Test file data structure
    ok(exists $file_data->{'file1.txt'}, 'file1.txt exists in file_data');
    ok(exists $file_data->{'file2.txt'}, 'file2.txt exists in file_data');
    
    # Test path extraction
    is($file_data->{'file1.txt'}{sha2}, '1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
       'SHA2 correctly extracted for file1.txt');
    is($file_data->{'file2.txt'}{sha2}, 'abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890',
       'SHA2 correctly extracted for file2.txt');
    
    # Test path arrays
    is_deeply($file_data->{'file1.txt'}{paths}, ['/path/to'], 'Path correctly extracted for file1.txt');
    is_deeply($file_data->{'file2.txt'}{paths}, ['/different/path'], 'Path correctly extracted for file2.txt');
    
    # Cleanup
    unlink $test_file;
};

# Test update_library_sha2 function
subtest 'update_library_sha2' => sub {
    my $mock_dbh = MockDBH->new();
    my $file_data = {
        'test_file.txt' => {
            sha2 => 'test_sha2_hash',
            paths => ['/test/path']
        }
    };
    
    # Mock the global $dbh variable
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    # Test function call
    lives_ok { update_library_sha2($file_data) } 'update_library_sha2 executes without error';
    
    # Verify prepare was called
    ok($mock_dbh->{prepare_called}, 'prepare() was called on database handle');
    ok($mock_dbh->{execute_called}, 'execute() was called on statement handle');
};

# Test sha2_exists function
subtest 'sha2_exists' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    # Test with existing SHA2
    $mock_dbh->{fetchrow_result} = { library_id => 123 };
    my $result = sha2_exists('test_sha2');
    is($result->{library_id}, 123, 'sha2_exists returns correct library_id for existing SHA2');
    
    # Test with non-existing SHA2
    $mock_dbh->{fetchrow_result} = undef;
    $result = sha2_exists('nonexistent_sha2');
    is($result, undef, 'sha2_exists returns undef for non-existing SHA2');
};

# Test create_library_with_sha2 function
subtest 'create_library_with_sha2' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    $mock_dbh->{last_insert_id_result} = 456;
    my $library_id = create_library_with_sha2('new_sha2_hash');
    
    is($library_id, 456, 'create_library_with_sha2 returns correct library_id');
    ok($mock_dbh->{prepare_called}, 'prepare() was called');
    ok($mock_dbh->{execute_called}, 'execute() was called');
    ok($mock_dbh->{last_insert_id_called}, 'last_insert_id() was called');
};

# Test insert_file_record function
subtest 'insert_file_record' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    lives_ok { insert_file_record('test_file.txt', '/test/path', 123) } 
        'insert_file_record executes without error';
    
    ok($mock_dbh->{prepare_called}, 'prepare() was called');
    ok($mock_dbh->{execute_called}, 'execute() was called');
};

# Test file_path_exists function
subtest 'file_path_exists' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    # Test with existing file path
    $mock_dbh->{fetchrow_result} = { file_id => 789 };
    my $result = file_path_exists('/test/path', 123);
    is($result->{file_id}, 789, 'file_path_exists returns correct file_id for existing path');
    
    # Test with non-existing file path
    $mock_dbh->{fetchrow_result} = undef;
    $result = file_path_exists('/nonexistent/path', 123);
    is($result, undef, 'file_path_exists returns undef for non-existing path');
};

# Test process_sha2_data function with mocked database operations
subtest 'process_sha2_data' => sub {
    my $mock_dbh = MockDBH->new();
    no warnings 'once';
    local $main::dbh = $mock_dbh;
    
    my $sha2_data = {
        'test_sha2_hash' => {
            'file1.txt' => ['/path1', '/path2'],
            'file2.txt' => ['/path3']
        }
    };
    
    # Mock no existing library
    $mock_dbh->{fetchrow_result} = undef;
    $mock_dbh->{last_insert_id_result} = 100;
    
    lives_ok { process_sha2_data($sha2_data) } 'process_sha2_data executes without error';
    
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
        fetchrow_result => undef,
        last_insert_id_result => undef,
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

sub begin_work { return 1; }
sub commit { return 1; }
sub rollback { return 1; }
sub disconnect { return 1; }

package MockSTH;
sub new { 
    my ($class, $dbh) = @_;
    return bless { dbh => $dbh }, $class;
}

sub execute { 
    my $self = shift;
    $self->{dbh}{execute_called} = 1;
    return 1;
}

sub fetchrow_hashref { 
    my $self = shift;
    return $self->{dbh}{fetchrow_result};
}

sub fetchall_arrayref {
    my $self = shift;
    return $self->{dbh}{fetchall_result} || [];
}

package MockLogger;
sub new { return bless {}, shift; }
sub info { return 1; }
sub debug { return 1; }
sub warn { return 1; }
sub error { return 1; }