#!/usr/bin/env perl

=head1 NAME

controller_library_validation.t - Unit tests for Library controller validation methods

=head1 DESCRIPTION

This test suite provides comprehensive unit testing for the validation and
parameter handling methods in the SequencesDB::Controller::Library controller.
It focuses on form validation, parameter extraction, and error handling.

=head2 Tested Methods

=over 4

=item * _extract_form_params - Form parameter extraction

=item * _validate_form_params - Form validation with error reporting

=item * _set_validation_errors - Error message handling

=item * _extract_search_params - Search parameter extraction

=item * _get_or_create_entity_ids - Entity ID management

=back

=head2 Test Strategy

=over 4

=item * Mock Objects - Catalyst context and model mocking

=item * Validation Testing - Comprehensive form validation coverage

=item * Edge Cases - Boundary conditions and error scenarios

=item * Parameter Handling - Input/output parameter verification

=back

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=head1 SEE ALSO

L<SequencesDB::Controller::Library>, L<Test::More>, L<Test::Mock::Guard>

=cut

use strict;
use warnings;
use Test::More;
use Test::Mock::Guard;

use Catalyst::Test 'SequencesDB';
use SequencesDB::Controller::Library;

# Create a controller instance for testing
my $controller = SequencesDB::Controller::Library->new();

# Test _extract_form_params method
subtest '_extract_form_params' => sub {
    # Mock Catalyst context
    my $mock_c = MockCatalystContext->new();
    
    # Set up request parameters
    $mock_c->{request_params} = {
        'filename' => 'test_file.txt',
        'sha2' => 'abc123',
        'path' => '/test/path',
        'organism' => '1',
        'input_tissue' => 'Brain',
        'repeat' => '2',
        'replicate' => '3',
    };
    
    my $params = $controller->_extract_form_params($mock_c);
    
    # Test extracted parameters
    is($params->{filename}, 'test_file.txt', 'filename parameter extracted correctly');
    is($params->{sha2}, 'abc123', 'sha2 parameter extracted correctly');
    is($params->{path}, '/test/path', 'path parameter extracted correctly');
    is($params->{organism_id}, '1', 'organism_id parameter extracted correctly');
    is($params->{tissue_name}, 'Brain', 'tissue_name parameter extracted correctly');
    is($params->{repeat}, '2', 'repeat parameter extracted correctly');
    is($params->{replicate}, '3', 'replicate parameter extracted correctly');
    
    # Test all expected parameter keys are present
    my @expected_keys = qw(
        filename file_id sha2 path repeat replicate
        organism_id organism_name tissue_id tissue_name
        cell_id cell_name experiment_id experiment_name
        background_id background_name method_id method_name
        antibody_id antibody_name sequencer_id sequencer_name
    );
    
    for my $key (@expected_keys) {
        exists $params->{$key} or fail("Missing parameter key: $key");
    }
    
    pass('All expected parameter keys are present');
};

# Test _validate_form_params method
subtest '_validate_form_params' => sub {
    # Test valid parameters
    my $valid_params = {
        filename => 'test_file.txt',
        sha2 => 'abc123def456',
        path => '/test/path',
        organism_id => '1',
        tissue_id => '2',
        cell_id => '3',
        experiment_id => '4',
        background_id => '5',
        method_id => '6',
        sequencer_id => '7',
        repeat => '1',
        replicate => '2',
    };
    
    my $errors = $controller->_validate_form_params($valid_params);
    is(scalar @$errors, 0, 'No validation errors for valid parameters');
    
    # Test missing required fields
    my $invalid_params = {
        # Missing filename, sha2, path
        organism_id => '1',
        repeat => '1',
        replicate => '2',
    };
    
    $errors = $controller->_validate_form_params($invalid_params);
    is(scalar @$errors, 10, 'Correct number of validation errors for missing fields');
    
    # Check specific error messages
    my $error_messages = join(' ', map { $_->{message} } @$errors);
    like($error_messages, qr/Insert filename/, 'Filename error message present');
    like($error_messages, qr/Insert a SHA2 key/, 'SHA2 error message present');
    like($error_messages, qr/Insert file path/, 'Path error message present');
    
    # Test invalid numeric fields
    my $invalid_numeric = {
        filename => 'test.txt',
        sha2 => 'abc123',
        path => '/test',
        organism_id => '1',
        tissue_id => '2',
        cell_id => '3',
        experiment_id => '4',
        background_id => '5',
        method_id => '6',
        sequencer_id => '7',
        repeat => 'invalid',
        replicate => 'also_invalid',
    };
    
    $errors = $controller->_validate_form_params($invalid_numeric);
    is(scalar @$errors, 2, 'Correct number of validation errors for invalid numeric fields');
    
    # Test entity validation (must have either ID or name)
    my $missing_entities = {
        filename => 'test.txt',
        sha2 => 'abc123',
        path => '/test',
        repeat => '1',
        replicate => '2',
        # No organism_id or organism_name
        # No tissue_id or tissue_name
        # etc.
    };
    
    $errors = $controller->_validate_form_params($missing_entities);
    is(scalar @$errors, 7, 'Correct number of validation errors for missing entities');
};

# Test _set_validation_errors method
subtest '_set_validation_errors' => sub {
    my $mock_c = MockCatalystContext->new();
    
    my $errors = [
        { field => 'filename', message => 'Insert filename!' },
        { field => 'sha2', message => 'Insert a SHA2 key!' },
        { field => 'path', message => 'Insert file path!' },
    ];
    
    $controller->_set_validation_errors($mock_c, $errors);
    
    # Check that errors were set in stash
    is($mock_c->{stash}{'error1'}, 'Insert filename!', 'First error set correctly');
    is($mock_c->{stash}{'error2'}, 'Insert a SHA2 key!', 'Second error set correctly');
    is($mock_c->{stash}{'error3'}, 'Insert file path!', 'Third error set correctly');
};

# Test _extract_search_params method
subtest '_extract_search_params' => sub {
    my $mock_c = MockCatalystContext->new();
    
    $mock_c->{request_params} = {
        'entries_per_page' => '25',
        'field_value' => 'test_search',
        'advanced_search' => 'organism',
        'search_options' => 'contains',
        'page' => '2',
    };
    
    my $params = $controller->_extract_search_params($mock_c);
    
    is($params->{entries_per_page}, '25', 'entries_per_page extracted correctly');
    is($params->{field_value}, 'test_search', 'field_value extracted correctly');
    is($params->{advanced_search}, 'organism', 'advanced_search extracted correctly');
    is($params->{search_options}, 'contains', 'search_options extracted correctly');
    is($params->{page_number}, '2', 'page_number extracted correctly');
    
    # Test defaults
    $mock_c->{request_params} = {};
    $params = $controller->_extract_search_params($mock_c);
    
    is($params->{entries_per_page}, 10, 'Default entries_per_page');
    is($params->{page_number}, 1, 'Default page_number');
};

# Test _get_or_create_entity_ids method
subtest '_get_or_create_entity_ids' => sub {
    my $mock_c = MockCatalystContext->new();
    
    # Set up mock model responses
    $mock_c->{model_responses} = {
        'DB::Organism' => MockDBRecord->new(123),
        'DB::Tissue' => MockDBRecord->new(456),
    };
    
    my $params = {
        organism_id => '1',
        tissue_name => 'Brain',
        cell_id => '2',
        experiment_name => 'RNA-seq',
        background_id => '3',
        method_name => 'Standard',
        antibody_id => '4',
        sequencer_name => 'Illumina',
    };
    
    my $ids = $controller->_get_or_create_entity_ids($mock_c, $params);
    
    # Test that existing IDs are preserved
    is($ids->{organism_id}, '1', 'Existing organism_id preserved');
    is($ids->{cell_id}, '2', 'Existing cell_id preserved');
    is($ids->{background_id}, '3', 'Existing background_id preserved');
    is($ids->{antibody_id}, '4', 'Existing antibody_id preserved');
    
    # Test that new entities are created for names
    is($ids->{tissue_id}, 456, 'New tissue_id created from name');
    is($ids->{experiment_id}, 123, 'New experiment_id created from name');
    is($ids->{method_id}, 456, 'New method_id created from name');
    is($ids->{sequencer_id}, 123, 'New sequencer_id created from name');
};

# Test validation edge cases
subtest 'validation_edge_cases' => sub {
    # Test zero values for numeric fields
    my $zero_params = {
        filename => 'test.txt',
        sha2 => 'abc123',
        path => '/test',
        organism_id => '1',
        tissue_id => '2',
        cell_id => '3',
        experiment_id => '4',
        background_id => '5',
        method_id => '6',
        sequencer_id => '7',
        repeat => '0',
        replicate => '0',
    };
    
    my $errors = $controller->_validate_form_params($zero_params);
    is(scalar @$errors, 0, 'Zero values accepted for numeric fields');
    
    # Test whitespace-only values
    my $whitespace_params = {
        filename => '  ',
        sha2 => "\t\n",
        path => '   ',
        organism_name => '  ',
        repeat => '1',
        replicate => '2',
    };
    
    $errors = $controller->_validate_form_params($whitespace_params);
    ok(scalar @$errors > 0, 'Whitespace-only values rejected');
};

done_testing();

# Mock classes for testing
package MockCatalystContext;
sub new {
    my $class = shift;
    return bless {
        request_params => {},
        stash => {},
        model_responses => {},
    }, $class;
}

sub req {
    my $self = shift;
    return MockRequest->new($self);
}

sub stash {
    my ($self, $key, $value) = @_;
    if (defined $value) {
        $self->{stash}{$key} = $value;
    }
    return $self->{stash}{$key};
}

sub model {
    my ($self, $model_name) = @_;
    return $self->{model_responses}{$model_name} || MockModel->new();
}

sub log {
    return MockLogger->new();
}

package MockRequest;
sub new {
    my ($class, $context) = @_;
    return bless { context => $context }, $class;
}

sub param {
    my ($self, $param_name) = @_;
    return $self->{context}{request_params}{$param_name};
}

package MockModel;
sub new {
    my $class = shift;
    return bless {}, $class;
}

sub create {
    my ($self, $data) = @_;
    return MockDBRecord->new(123); # Mock ID
}

package MockDBRecord;
sub new {
    my ($class, $id) = @_;
    return bless { id => $id }, $class;
}

sub id {
    my $self = shift;
    return $self->{id};
}

package MockLogger;
sub new { return bless {}, shift; }
sub info { return 1; }
sub debug { return 1; }
sub warn { return 1; }
sub error { return 1; }