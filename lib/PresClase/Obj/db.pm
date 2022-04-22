package PresClase::Obj::db;
use Mojo::Base -base;

use Mojo::SQLite;
use PresClase::Model::DB;

has sqlite => sub { Mojo::SQLite->new('sqlite:data/presentacio.db') };

has model  => sub {
	my $self = shift;
	return PresClase::Model::DB->new( sqlite =>  $self->sqlite );
};

1;
