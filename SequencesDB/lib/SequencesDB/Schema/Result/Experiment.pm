use utf8;
package SequencesDB::Schema::Result::Experiment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SequencesDB::Schema::Result::Experiment

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

=head1 TABLE: C<Experiment>

=cut

__PACKAGE__->table("Experiment");

=head1 ACCESSORS

=head2 experiment_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 experiment_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "experiment_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "experiment_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</experiment_id>

=back

=cut

__PACKAGE__->set_primary_key("experiment_id");

=head1 RELATIONS

=head2 libraries

Type: has_many

Related object: L<SequencesDB::Schema::Result::Library>

=cut

__PACKAGE__->has_many(
  "libraries",
  "SequencesDB::Schema::Result::Library",
  { "foreign.experiment_experiment_id" => "self.experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-08 11:50:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IoGCDXkalYH4+04nQjG7Fw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
