use utf8;
package SequencesDB::Schema::Result::ReadType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SequencesDB::Schema::Result::ReadType

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

=head1 TABLE: C<Read_Type>

=cut

__PACKAGE__->table("Read_Type");

=head1 ACCESSORS

=head2 library_library_id

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 library_library_id1

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "library_library_id",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "library_library_id1",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</library_library_id>

=item * L</library_library_id1>

=back

=cut

__PACKAGE__->set_primary_key("library_library_id", "library_library_id1");

=head1 RELATIONS

=head2 library_library

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library_library",
  "SequencesDB::Schema::Result::Library",
  { library_id => "library_library_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 library_library_id1

Type: belongs_to

Related object: L<SequencesDB::Schema::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library_library_id1",
  "SequencesDB::Schema::Result::Library",
  { library_id => "library_library_id1" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-08 11:50:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:X+WrRUq6Bh24XeQ5b7E+ug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
