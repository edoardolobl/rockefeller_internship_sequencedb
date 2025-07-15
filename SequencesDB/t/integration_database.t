#!/usr/bin/env perl

=head1 NAME

integration_database.t - Integration tests for complete database workflows

=head1 DESCRIPTION

This test suite provides comprehensive integration testing for complete
database workflows in the SequencesDB application. It tests end-to-end
scenarios that span multiple models and complex business logic.

=head2 Test Scenarios

=over 4

=item * Complete Workflow - Full library creation with all relationships

=item * Paired-End Reads - Paired-end sequencing data handling

=item * Complex Searches - Multi-table search operations

=item * Transaction Handling - ACID compliance and rollback testing

=item * Bulk Operations - High-volume data processing

=back

=head2 Integration Strategy

=over 4

=item * Real Database - Full database operations with transactions

=item * Complete Workflows - End-to-end business process testing

=item * Relationship Validation - Cross-table relationship integrity

=item * Performance Testing - Bulk operations and scalability

=back

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=head1 SEE ALSO

L<SequencesDB::Schema>, L<Test::DBIx::Class>, L<Test::More>

=cut

use strict;
use warnings;
use Test::More;
use Test::DBIx::Class;
use FindBin qw($Bin);
use lib "$Bin/../lib";

# Load the schema and test fixtures
fixtures_ok 'integration';

# Test complete workflow: create library with all related entities
subtest 'Complete library creation workflow' => sub {
    my $schema = Schema();
    
    # Step 1: Create all entity types
    my $organism = $schema->resultset('Organism')->create({
        organism_name => 'Homo sapiens'
    });
    
    my $tissue = $schema->resultset('Tissue')->create({
        tissue_name => 'Brain cortex'
    });
    
    my $cell = $schema->resultset('Cell')->create({
        cell_name => 'Neurons'
    });
    
    my $experiment = $schema->resultset('Experiment')->create({
        experiment_name => 'RNA-seq differential expression'
    });
    
    my $background = $schema->resultset('Background')->create({
        background_name => 'Control'
    });
    
    my $method = $schema->resultset('Method')->create({
        method_name => 'TruSeq RNA Library Prep'
    });
    
    my $antibody = $schema->resultset('Antibody')->create({
        antibody_name => 'Anti-H3K4me3'
    });
    
    my $sequencer = $schema->resultset('Sequencer')->create({
        sequencer_name => 'Illumina HiSeq 4000'
    });
    
    # Step 2: Create library with all relationships
    my $library = $schema->resultset('Library')->create({
        sha2 => 'integration_test_complete_workflow_sha2',
        organism_organism_id => $organism->organism_id,
        tissue_tissue_id => $tissue->tissue_id,
        cell_cell_id => $cell->cell_id,
        experiment_experiment_id => $experiment->experiment_id,
        background_background_id => $background->background_id,
        method_method_id => $method->method_id,
        antibody_antibody_id => $antibody->antibody_id,
        sequencer_sequencer_id => $sequencer->sequencer_id,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    # Step 3: Create associated files
    my $file1 = $schema->resultset('File')->create({
        file_name => 'sample_R1.fastq.gz',
        file_path => '/data/raw/experiment1',
        library_library_id => $library->library_id,
    });
    
    my $file2 = $schema->resultset('File')->create({
        file_name => 'sample_R2.fastq.gz',
        file_path => '/data/raw/experiment1',
        library_library_id => $library->library_id,
    });
    
    # Step 4: Verify complete workflow
    ok($library->library_id, 'Library created with ID');
    is($library->organism_organism->organism_name, 'Homo sapiens', 'Organism linked correctly');
    is($library->tissue_tissue->tissue_name, 'Brain cortex', 'Tissue linked correctly');
    is($library->cell_cell->cell_name, 'Neurons', 'Cell linked correctly');
    is($library->experiment_experiment->experiment_name, 'RNA-seq differential expression', 'Experiment linked correctly');
    is($library->background_background->background_name, 'Control', 'Background linked correctly');
    is($library->method_method->method_name, 'TruSeq RNA Library Prep', 'Method linked correctly');
    is($library->antibody_antibody->antibody_name, 'Anti-H3K4me3', 'Antibody linked correctly');
    is($library->sequencer_sequencer->sequencer_name, 'Illumina HiSeq 4000', 'Sequencer linked correctly');
    
    # Verify files are linked
    my $files = $library->files_inner;
    is($files->count, 2, 'Two files linked to library');
    
    my @file_names = sort map { $_->file_name } $files->all;
    is_deeply(\@file_names, ['sample_R1.fastq.gz', 'sample_R2.fastq.gz'], 'File names correct');
};

# Test paired-end read type relationships
subtest 'Paired-end read type workflow' => sub {
    my $schema = Schema();
    
    # Create two libraries for paired-end reads
    my $library1 = $schema->resultset('Library')->create({
        sha2 => 'paired_end_test_sha2_read1',
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
        sha2 => 'paired_end_test_sha2_read2',
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
    
    # Create read type relationship
    my $read_type = $schema->resultset('ReadType')->create({
        library_library_id => $library1->library_id,
        library_library_id1 => $library2->library_id,
    });
    
    ok($read_type, 'ReadType relationship created');
    is($read_type->library_library_id, $library1->library_id, 'First library linked correctly');
    is($read_type->library_library_id1, $library2->library_id, 'Second library linked correctly');
};

# Test search functionality across relationships
subtest 'Complex search across relationships' => sub {
    my $schema = Schema();
    
    # Create test data with specific search criteria
    my $human_organism = $schema->resultset('Organism')->create({
        organism_name => 'Homo sapiens'
    });
    
    my $mouse_organism = $schema->resultset('Organism')->create({
        organism_name => 'Mus musculus'
    });
    
    my $brain_tissue = $schema->resultset('Tissue')->create({
        tissue_name => 'Brain'
    });
    
    my $liver_tissue = $schema->resultset('Tissue')->create({
        tissue_name => 'Liver'
    });
    
    # Create libraries with different combinations
    my $human_brain_lib = $schema->resultset('Library')->create({
        sha2 => 'search_test_human_brain',
        organism_organism_id => $human_organism->organism_id,
        tissue_tissue_id => $brain_tissue->tissue_id,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 1,
        replicate_id => 1,
    });
    
    my $mouse_liver_lib = $schema->resultset('Library')->create({
        sha2 => 'search_test_mouse_liver',
        organism_organism_id => $mouse_organism->organism_id,
        tissue_tissue_id => $liver_tissue->tissue_id,
        cell_cell_id => 1,
        experiment_experiment_id => 1,
        background_background_id => 1,
        method_method_id => 1,
        sequencer_sequencer_id => 1,
        repeat_id => 2,
        replicate_id => 1,
    });
    
    # Search for human samples
    my $human_libraries = $schema->resultset('Library')->search(
        { 'organism_organism.organism_name' => 'Homo sapiens' },
        { join => 'organism_organism' }
    );
    
    is($human_libraries->count, 1, 'One human library found');
    is($human_libraries->first->sha2, 'search_test_human_brain', 'Correct human library found');
    
    # Search for brain samples
    my $brain_libraries = $schema->resultset('Library')->search(
        { 'tissue_tissue.tissue_name' => 'Brain' },
        { join => 'tissue_tissue' }
    );
    
    is($brain_libraries->count, 1, 'One brain library found');
    is($brain_libraries->first->sha2, 'search_test_human_brain', 'Correct brain library found');
    
    # Complex search: human brain samples
    my $human_brain_libraries = $schema->resultset('Library')->search(
        { 
            'organism_organism.organism_name' => 'Homo sapiens',
            'tissue_tissue.tissue_name' => 'Brain'
        },
        { join => ['organism_organism', 'tissue_tissue'] }
    );
    
    is($human_brain_libraries->count, 1, 'One human brain library found');
    is($human_brain_libraries->first->sha2, 'search_test_human_brain', 'Correct human brain library found');
};

# Test transaction handling and rollback
subtest 'Transaction handling and rollback' => sub {
    my $schema = Schema();
    
    # Test successful transaction
    my $library;
    $schema->txn_do(sub {
        $library = $schema->resultset('Library')->create({
            sha2 => 'transaction_test_success',
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
        
        $schema->resultset('File')->create({
            file_name => 'transaction_test.txt',
            file_path => '/test/path',
            library_library_id => $library->library_id,
        });
    });
    
    # Verify transaction committed
    my $found_library = $schema->resultset('Library')->find({ sha2 => 'transaction_test_success' });
    ok($found_library, 'Library committed in successful transaction');
    is($found_library->files_inner->count, 1, 'File committed in successful transaction');
    
    # Test failed transaction
    eval {
        $schema->txn_do(sub {
            my $failing_library = $schema->resultset('Library')->create({
                sha2 => 'transaction_test_failure',
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
            
            # This should cause the transaction to fail
            die "Intentional failure for testing rollback";
        });
    };
    
    # Verify transaction rolled back
    my $failed_library = $schema->resultset('Library')->find({ sha2 => 'transaction_test_failure' });
    ok(!$failed_library, 'Library rolled back in failed transaction');
};

# Test bulk operations and performance
subtest 'Bulk operations' => sub {
    my $schema = Schema();
    
    # Create multiple libraries in bulk
    my @library_data;
    for my $i (1..10) {
        push @library_data, {
            sha2 => "bulk_test_sha2_$i",
            organism_organism_id => 1,
            tissue_tissue_id => 1,
            cell_cell_id => 1,
            experiment_experiment_id => 1,
            background_background_id => 1,
            method_method_id => 1,
            sequencer_sequencer_id => 1,
            repeat_id => $i,
            replicate_id => 1,
        };
    }
    
    # Bulk insert
    $schema->resultset('Library')->populate(\@library_data);
    
    # Verify bulk insert
    my $bulk_libraries = $schema->resultset('Library')->search(
        { sha2 => { like => 'bulk_test_sha2_%' } }
    );
    
    is($bulk_libraries->count, 10, 'All 10 libraries created in bulk operation');
    
    # Test bulk update
    $bulk_libraries->update({ replicate_id => 999 });
    
    # Verify bulk update
    my $updated_libraries = $schema->resultset('Library')->search(
        { 
            sha2 => { like => 'bulk_test_sha2_%' },
            replicate_id => 999
        }
    );
    
    is($updated_libraries->count, 10, 'All 10 libraries updated in bulk operation');
};

done_testing();

# Test fixtures for integration tests
__DATA__
@integration
[
  {
    "class": "Organism",
    "data": {
      "organism_id": 1,
      "organism_name": "Default Test Organism"
    }
  },
  {
    "class": "Tissue",
    "data": {
      "tissue_id": 1,
      "tissue_name": "Default Test Tissue"
    }
  },
  {
    "class": "Cell",
    "data": {
      "cell_id": 1,
      "cell_name": "Default Test Cell"
    }
  },
  {
    "class": "Experiment",
    "data": {
      "experiment_id": 1,
      "experiment_name": "Default Test Experiment"
    }
  },
  {
    "class": "Background",
    "data": {
      "background_id": 1,
      "background_name": "Default Test Background"
    }
  },
  {
    "class": "Method",
    "data": {
      "method_id": 1,
      "method_name": "Default Test Method"
    }
  },
  {
    "class": "Sequencer",
    "data": {
      "sequencer_id": 1,
      "sequencer_name": "Default Test Sequencer"
    }
  }
]