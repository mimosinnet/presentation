package PresClase;
use Mojo::Base 'Mojolicious';
use PresClase::Schema;
use PresClase::Model::Diapos;
use PresClase::Objects::ReadSlide;

has schema => sub {
	return PresClase::Schema->connect('dbi:SQLite:dbname=data/presentacio.db', '', '', 
		{sqlite_unicode => 1 } 
	) || die "Cannot connect";
};

# This method will run once at server start
sub startup {
  my $self = shift;

	my $config = $self->plugin('Config', file => 'presentacions.conf');
	$self->secrets( $config->{'secrets'} );

	# Helpers {{{
	$self->helper(db => sub { $self->app->schema });
	$self->helper(
     m_pres => sub { state $m_llei = PresClase::Model::Diapos->new(db => shift->db) });
	$self->helper( slide => sub {
			my ($self,$id_pres,$id_diapo) = @_;
			return PresClase::Objects::ReadSlide->new( 
				id_pres => $id_pres, 
				id_diapo => $id_diapo,
			);
		}
	);
	# }}}

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('presenta#llista_pres');
	$r->get('/llista_pres')->to('presenta#llista_pres');
	$r->get('/presenta/:id/:diapo')->to('presenta#presenta');
	$r->get('/admin/update')->to('presenta#update');
	$r->get('/show_markdown/:id')->to('presenta#show_markdown');
	$r->get('/diapos/:id')->to('presenta#diapos');
}

1;

# vim: tabstop=2 shiftwidth=2
