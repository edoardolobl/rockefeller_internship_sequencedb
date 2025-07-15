#!/usr/bin/env perl

=head1 NAME

schema_library.t - Unit tests for Library schema result class

=head1 DESCRIPTION

This test suite provides comprehensive unit testing for the Library schema
result class, focusing on database operations, relationships, and data
integrity for the core Library model in the SequencesDB application.

=head2 Test Coverage

=over 4

=item * Model Creation - Library record creation and validation

=item * Relationships - Foreign key relationships with all entities

=item * Search Operations - Library search and filtering

=item * Data Validation - Constraint checking and error handling

=item * CRUD Operations - Create, Read, Update, Delete operations

=back

=head2 Test Strategy

=over 4

=item * Test Fixtures - Predefined test data for consistency

=item * Database Testing - Real database operations with transactions

=item * Relationship Testing - Foreign key and join validations

=item * Edge Cases - Boundary conditions and constraint violations

=back

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=head1 SEE ALSO

L<SequencesDB::Schema::Result::Library>, L<Test::DBIx::Class>, L<Test::More>

=cut

use strict;
use warnings;
use Test::More;
use Test::DBIx::Class;
use FindBin qw($Bin);
use lib "$Bin/../lib";

# Load the schema and test fixtures
fixtures_ok 'basic';

# Test Library model basic functionality
subtest 'Library model basics' => sub {
    my $schema = Schema();
    
    # Test table existence
    ok($schema->resultset('Library'), 'Library resultset exists');
    
    # Test creating a new library
    my $library = $schema->resultset('Library')->create({
        sha2 => 'test_sha2_hash_for_library_creation',
        organism_organism_id => 1,
        tissue_tissue_id => 1,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    ok($library, 'Library created successfully');
    ok($library->library_id, 'Library has an ID');
    is($library->sha2, 'test_sha2_hash_for_library_creation', 'SHA2 value correct');
    is($library->repeat_id, 1, 'Repeat ID correct');
    is($library->replicate_id, 1, 'Replicate ID correct');
};

# Test Library relationships
subtest 'Library relationships' => sub {
    my $schema = Schema();
    
    # Create related records first
    my $organism = $schema->resultset('Organism')->create({
        organism_name => 'Test Organism'
    });
    
    my $tissue = $schema->resultset('Tissue')->create({
        tissue_name => 'Test Tissue'
    });
    
    my $cell = $schema->resultset('Cell')->create({
        cell_name => 'Test Cell'
    });
    
    my $experiment = $schema->resultset('Experiment')->create({
        experiment_name => 'Test Experiment'
    });
    
    my $background = $schema->resultset('Background')->create({
        background_name => 'Test Background'
    });
    
    my $method = $schema->resultset('Method')->create({
        method_name => 'Test Method'
    });
    
    my $sequencer = $schema->resultset('Sequencer')->create({
        sequencer_name => 'Test Sequencer'
    });
    
    # Create library with relationships
    my $library = $schema->resultset('Library')->create({
        sha2 => 'test_sha2_hash_for_relationships',
        organism_organism_id => $organism->organism_id,
        tissue_tissue_id => $tissue->tissue_id,
        cell_cell_id => $cell->cell_id,
        experiment_experiment_id => $experiment->experiment_id,
        background_background_id => $background->background_id,
        method_method_id => $method->method_id,
        sequencer_sequencer_id => $sequencer->sequencer_id,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    # Test relationships
    ok($library->organism_organism, 'Organism relationship exists');
    is($library->organism_organism->organism_name, 'Test Organism', 'Organism relationship correct');
    
    ok($library->tissue_tissue, 'Tissue relationship exists');
    is($library->tissue_tissue->tissue_name, 'Test Tissue', 'Tissue relationship correct');
    
    ok($library->cell_cell, 'Cell relationship exists');
    is($library->cell_cell->cell_name, 'Test Cell', 'Cell relationship correct');
    
    ok($library->experiment_experiment, 'Experiment relationship exists');
    is($library->experiment_experiment->experiment_name, 'Test Experiment', 'Experiment relationship correct');
    
    ok($library->background_background, 'Background relationship exists');
    is($library->background_background->background_name, 'Test Background', 'Background relationship correct');
    
    ok($library->method_method, 'Method relationship exists');
    is($library->method_method->method_name, 'Test Method', 'Method relationship correct');
    
    ok($library->sequencer_sequencer, 'Sequencer relationship exists');
    is($library->sequencer_sequencer->sequencer_name, 'Test Sequencer', 'Sequencer relationship correct');
};

# Test Library file relationships
subtest 'Library file relationships' => sub {
    my $schema = Schema();
    
    # Create a library
    my $library = $schema->resultset('Library')->create({
        sha2 => 'test_sha2_hash_for_files',
        organism_organism_id => 1,
        tissue_tissue_id => 1,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    # Create files associated with the library
    my $file1 = $schema->resultset('File')->create({
        file_name => 'test_file1.txt',
        file_path => '/path/to/test1',
        library_library_id => $library->library_id,
    });
    
    my $file2 = $schema->resultset('File')->create({
        file_name => 'test_file2.txt',
        file_path => '/path/to/test2',
        library_library_id => $library->library_id,
    });
    
    # Test file relationships
    my $files = $library->files_inner;
    ok($files, 'Files relationship exists');
    is($files->count, 2, 'Correct number of files associated');
    
    my @file_names = sort map { $_->file_name } $files->all;
    is_deeply(\@file_names, ['test_file1.txt', 'test_file2.txt'], 'File names correct');
};

# Test Library search functionality
subtest 'Library search functionality' => sub {
    my $schema = Schema();
    
    # Create test libraries with different SHA2 values
    my $library1 = $schema->resultset('Library')->create({
        sha2 => 'search_test_sha2_alpha',
        organism_organism_id => 1,
        tissue_tissue_id => 1,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    my $library2 = $schema->resultset('Library')->create({
        sha2 => 'search_test_sha2_beta',
        organism_organism_id => 1,
        tissue_tissue_id => 1,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 2,
        replicate_id => 2,
    });
    
    # Test search by SHA2
    my $found_library = $schema->resultset('Library')->find({ sha2 => 'search_test_sha2_alpha' });
    ok($found_library, 'Library found by SHA2');
    is($found_library->library_id, $library1->library_id, 'Correct library found');
    
    # Test search by repeat_id
    my $repeat_libraries = $schema->resultset('Library')->search({ repeat_id => 2 });
    is($repeat_libraries->count, 1, 'Correct number of libraries found by repeat_id');
    is($repeat_libraries->first->library_id, $library2->library_id, 'Correct library found by repeat_id');
};

# Test Library validation and constraints
subtest 'Library validation and constraints' => sub {
    my $schema = Schema();
    
    # Test SHA2 uniqueness
    my $library1 = $schema->resultset('Library')->create({
        sha2 => 'unique_test_sha2',
        organism_organism_id => 1,
        tissue_tissue_id => 1,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    # Attempting to create another library with the same SHA2 should fail
    eval {
        my $library2 = $schema->resultset('Library')->create({
            sha2 => 'unique_test_sha2',
            organism_organism_id => 1,
            tissue_tissue_id => 1,
            cell_cell_id => 1,
            experiment_experiment_id => 1,
            background_background_id => 1,
            method_method_id => 1,
            sequencer_sequencer_id => 1,
            repeat_id => 2,
            replicate_id => 2,
        });
    };
    
    ok($@, 'Duplicate SHA2 creation fails as expected');
};

# Test Library updates
subtest 'Library updates' => sub {
    my $schema = Schema();
    
    my $library = $schema->resultset('Library')->create({
        sha2 => 'update_test_sha2',
        organism_organism_id => 1,
        tissue_tissue_id => 1,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    # Update the library
    $library->update({
        repeat_id => 5,
        replicate_id => 3,
    });
    
    # Verify updates
    $library->discard_changes;
    is($library->repeat_id, 5, 'Repeat ID updated correctly');
    is($library->replicate_id, 3, 'Replicate ID updated correctly');
    is($library->sha2, 'update_test_sha2', 'SHA2 unchanged after update');
};

# Test Library deletion
subtest 'Library deletion' => sub {
    my $schema = Schema();
    
    my $library = $schema->resultset('Library')->create({
        sha2 => 'delete_test_sha2',
        organism_organism_id => 1,
        tissue_tissue_id => 1,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    my $library_id = $library->library_id;
    
    # Delete the library
    $library->delete;
    
    # Verify deletion
    my $deleted_library = $schema->resultset('Library')->find($library_id);
    ok(!$deleted_library, 'Library deleted successfully');
};

done_testing();

# Test fixtures
__DATA__
@basic
[
  {
    "class": "Organism",
    "data": {
      "organism_id": 1,
      "organism_name": "Test Organism Default"
    }
  },
  {
    "class": "Tissue",
    "data": {
      "tissue_id": 1,
      "tissue_name": "Test Tissue Default"
    }
  },
  {
    "class": "Cell",
    "data": {
      "cell_id": 1,
      "cell_name": "Test Cell Default"
    }
  },
  {
    "class": "Experiment",
    "data": {
      "experiment_id": 1,
      "experiment_name": "Test Experiment Default"
    }
  },
  {
    "class": "Background",
    "data": {
      "background_id": 1,
      "background_name": "Test Background Default"
    }
  },
  {
    "class": "Method",
    "data": {
      "method_id": 1,
      "method_name": "Test Method Default"
    }
  },
  {
    "class": "Sequencer",
    "data": {
      "sequencer_id": 1,
      "sequencer_name": "Test Sequencer Default"
    }
  }
]