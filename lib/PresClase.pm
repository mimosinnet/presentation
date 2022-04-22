package PresClase;
use Mojo::Base 'Mojolicious';
use PresClase::Obj::db;
use PresClase::Obj::ReadSlide;

# This method will run once at server start
sub startup {
  my $self = shift;

	# Plugins {{{
	my $config = $self->plugin('Config', file => 'presentacions.conf');
	$self->secrets(['NovaParaulaClau per les cookies 1421452135512']);
	# }}}

	# Helpers {{{
	# Get slide info
	$self->helper( slide => sub {
			my ($self,$id_pres,$id_slide) = @_;
			return PresClase::Obj::ReadSlide->new( 
				id_pres => $id_pres, 
				id_slide => $id_slide,
			);
		}
	);

  # database model availabe as $self->model {{{
  $self->helper( model => sub { 
			state $model = PresClase::Obj::db->new->model;
		}
	);
	# }}}

	# }}}

  # Router
  my $r = $self->routes;
  # routes
  $r->get('/')->to('presenta#list_presentations');
  $r->get('/cursos')->to('presenta#cursos');
  $r->get('/curs/:id')->to('presenta#curs');
	$r->get('/list_presentations')->to('presenta#list_presentations');
	$r->get('/presenta/:id/:diapo')->to('presenta#presenta');
	$r->get('/admin/update')->to('presenta#update');
	$r->get('/show_markdown/:id')->to('presenta#show_markdown');
	$r->get('/diapos/:id')->to('presenta#diapos');
	$r->get('/slides/:id')->to('presenta#slides');
}

1;

# vim: tabstop=2 shiftwidth=2
