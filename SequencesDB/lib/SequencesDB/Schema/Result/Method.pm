use utf8;
package SequencesDB::Schema::Result::Method;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SequencesDB::Schema::Result::Method

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

=head1 TABLE: C<Method>

=cut

__PACKAGE__->table("Method");

=head1 ACCESSORS

=head2 method_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 method_name

  data_type: 'varchar'
  is_nullable: 1
  size: 150

=cut

__PACKAGE__->add_columns(
  "method_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "method_name",
  { data_type => "varchar", is_nullable => 1, size => 150 },
);

=head1 PRIMARY KEY

=over 4

=item * L</method_id>

=back

=cut

__PACKAGE__->set_primary_key("method_id");

=head1 RELATIONS

=head2 libraries

Type: has_many

Related object: L<SequencesDB::Schema::Result::Library>

=cut

__PACKAGE__->has_many(
  "libraries",
  "SequencesDB::Schema::Result::Library",
  { "foreign.method_method_id" => "self.method_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-08 11:50:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/Jr9fgGsxG0l9/JgUHhb5g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
