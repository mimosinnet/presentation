use utf8;
package PresClase::Schema::Result::Presentacio;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PresClase::Schema::Result::Presentacio

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Presentacio>

=cut

__PACKAGE__->table("Presentacio");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 presentacio

  data_type: 'text'
  is_nullable: 0

=head2 diapositives

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "presentacio",
  { data_type => "text", is_nullable => 0 },
  "diapositives",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-12-23 20:45:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:coJjeKmZGdw4CeQhdIb2Dw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
