use utf8;
package PresClase::Schema::Result::Diapositiva;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PresClase::Schema::Result::Diapositiva

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<diapositiva>

=cut

__PACKAGE__->table("diapositiva");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 numero

  data_type: 'integer'
  is_nullable: 0

=head2 diapositiva

  data_type: 'blob'
  is_nullable: 0

=head2 presentacio

  data_type: 'integer'
  is_nullable: 0

=head2 background

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "numero",
  { data_type => "integer", is_nullable => 0 },
  "diapositiva",
  { data_type => "blob", is_nullable => 0 },
  "presentacio",
  { data_type => "integer", is_nullable => 0 },
  "background",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-01-02 11:46:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iW6EvSWHeXzdc4WGUybdpA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
