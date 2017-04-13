package PresClase;
use Mojo::Base 'Mojolicious';
use PresClase::Schema;
use PresClase::Model::Slides;
use PresClase::Objects::ReadSlide;

has schema => sub {
	return PresClase::Schema->connect('dbi:SQLite:dbname=data/presentacio.db', '', '', 
		{sqlite_unicode => 1 } 
	) || die "Cannot connect";
};

# This method will run once at server start
sub startup {
  my $self = shift;

	# Plugins {{{
	my $config = $self->plugin('Config', file => 'presentacions.conf');
	$self->secrets( $config->{'secrets'} );

	$self->plugin('RevealJS');
	# }}}

	# Helpers {{{
	$self->helper(db => sub { $self->app->schema });
	$self->helper(
     m_pres => sub { state $m_llei = PresClase::Model::Slides->new(db => shift->db) });
	$self->helper( slide => sub {
			my ($self,$id_pres,$id_slide) = @_;
			return PresClase::Objects::ReadSlide->new( 
				id_pres => $id_pres, 
				id_slide => $id_slide,
			);
		}
	);
	# }}}

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('presenta#list_presentations');
	$r->get('/list_presentations')->to('presenta#list_presentations');
	$r->get('/presenta/:id/:diapo')->to('presenta#presenta');
	$r->get('/admin/update')->to('presenta#update');
	$r->get('/show_markdown/:id')->to('presenta#show_markdown');
	$r->get('/diapos/:id')->to('presenta#diapos');
	$r->get('/reveal/:id')->to('presenta#reveal');
	$r->get('/remark/:id')->to('presenta#remark');
}

1;

# vim: tabstop=2 shiftwidth=2
