use utf8;
package SequencesDB::Schema::Result::Library;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SequencesDB::Schema::Result::Library - Database schema for sequence library records

=head1 DESCRIPTION

This DBIx::Class result class represents the Library table in the SequencesDB
database schema. It defines the structure and relationships for sequence library
records that contain bioinformatics experimental metadata.

=head2 Purpose

The Library table is the central entity in the SequencesDB system, storing
metadata about biological samples and their associated sequencing experiments.
It connects files to their biological context through foreign key relationships.

=head2 Key Features

=over 4

=item * SHA2 hash tracking for file integrity

=item * Experimental metadata storage (repeats, replicates)

=item * Biological context relationships (organism, tissue, cell)

=item * Methodological metadata (experiment, method, sequencer)

=item * Optional antibody information for specific experiments

=back

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<Library>

=cut

__PACKAGE__->table("Library");

=head1 ACCESSORS

=head2 library_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 repeat_id

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 replicate_id

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 sha2

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 organism_organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 tissue_tissue_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 cell_cell_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 experiment_experiment_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 method_method_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 sequencer_sequencer_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 background_background_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 antibody_antibody_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "library_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "repeat_id",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "replicate_id",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "sha2",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "organism_organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "tissue_tissue_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cell_cell_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "experiment_experiment_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "method_method_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "sequencer_sequencer_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "background_background_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "antibody_antibody_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</library_id>

=back

=cut

__PACKAGE__->set_primary_key("library_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<SHA2_UNIQUE>

=over 4

=item * L</sha2>

=back

=cut

__PACKAGE__->add_unique_constraint("SHA2_UNIQUE", ["sha2"]);

=head1 RELATIONS

=head2 antibody_antibody

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Antibody>

=cut

__PACKAGE__->belongs_to(
  "antibody_antibody",
  "SequencesDB::Schema::Result::Antibody",
  { antibody_id => "antibody_antibody_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

=head2 background_background

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Background>

=cut

__PACKAGE__->belongs_to(
  "background_background",
  "SequencesDB::Schema::Result::Background",
  { background_id => "background_background_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

=head2 cell_cell

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Cell>

=cut

__PACKAGE__->belongs_to(
  "cell_cell",
  "SequencesDB::Schema::Result::Cell",
  { cell_id => "cell_cell_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

=head2 experiment_experiment

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Experiment>

=cut

__PACKAGE__->belongs_to(
  "experiment_experiment",
  "SequencesDB::Schema::Result::Experiment",
  { experiment_id => "experiment_experiment_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

=head2 files

Type: has_many

Related object: L<SequencesDB::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "SequencesDB::Schema::Result::File",
  { "foreign.library_library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 method_method

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Method>

=cut

__PACKAGE__->belongs_to(
  "method_method",
  "SequencesDB::Schema::Result::Method",
  { method_id => "method_method_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

=head2 organism_organism

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "organism_organism",
  "SequencesDB::Schema::Result::Organism",
  { organism_id => "organism_organism_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

=head2 read_type_library_libraries

Type: has_many

Related object: L<SequencesDB::Schema::Result::ReadType>

=cut

__PACKAGE__->has_many(
  "read_type_library_libraries",
  "SequencesDB::Schema::Result::ReadType",
  { "foreign.library_library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 read_type_library_library_id1s

Type: has_many

Related object: L<SequencesDB::Schema::Result::ReadType>

=cut

__PACKAGE__->has_many(
  "read_type_library_library_id1s",
  "SequencesDB::Schema::Result::ReadType",
  { "foreign.library_library_id1" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sequencer_sequencer

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Sequencer>

=cut

__PACKAGE__->belongs_to(
  "sequencer_sequencer",
  "SequencesDB::Schema::Result::Sequencer",
  { sequencer_id => "sequencer_sequencer_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

=head2 tissue_tissue

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Tissue>

=cut

__PACKAGE__->belongs_to(
  "tissue_tissue",
  "SequencesDB::Schema::Result::Tissue",
  { tissue_id => "tissue_tissue_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "CASCADE",
  },
);

# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-08 11:50:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WpoFp0XhifkSMsmaNh5O8w

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->has_many(
  "files_inner",
  "SequencesDB::Schema::Result::File",
  { "foreign.library_library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0, join_type => 'inner' },
);



__PACKAGE__->meta->make_immutable;


1;
