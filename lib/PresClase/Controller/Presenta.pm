package PresClase::Controller::Presenta;
use Mojo::Base 'Mojolicious::Controller';
# Text::Markdown is used to show the entire markdown file
use Text::Markdown qw{ markdown };
use PresClase::Obj::ReadMarkdown;
use PresClase::Obj::ReadSlide;

# Cursos {{{
sub cursos {
	my $self = shift;

	$self->render(
		title 				=> "Llistat de Cursos - Mòduls",
		cursos        => $self->model->cursos,
	);
}
# }}}

# Curs {{{
sub curs {
	my $self = shift;
  my $id_curs = $self->stash('id');

	$self->render(
		title 	  => "Llista de Sessions: " . $self->model->curs($id_curs),
		pres_curs => $self->model->pres_curs($id_curs),
	);
}
# }}}

# List presentations {{{
sub list_presentations {
	my $self = shift;

	$self->render(
		title 				=> "Llista de Presentacions",
		pres					=> $self->model->pres,
		n_pres_in_db	=> $self->model->n_pres,
	);
}
# }}}

# Show slide {{{
sub presenta {
	my $self = shift;
	my ($id_pres,$id_slide)	= ( $self->stash('id'), $self->stash('diapo') );

	# mirar si existeix la diapositiva (i.e., presentació esborrada)
	if ( $self->model->slide_exist( $id_pres, $id_slide) ) {
		$self->render(
			id_pres			=> $id_pres,
			id_slide		=> $id_slide,
      id_course   => $self->model->pres_id($id_pres)->{'Curs_id'},
		);
	} else {
		$self->flash( message => "La diapositiva $id_slide de la presentació $id_pres no existeix");
 		$self->redirect_to('/list_presentations');
	}

}
# }}}

# Show markdown file {{{
sub show_markdown {
	my $self 		= shift;
	my $id_pres	= $self->stash('id');

	# Read Markdown File
	my $read_markdown = PresClase::Obj::ReadMarkdown->new( id_pres => $id_pres);
	my $titol 				= $read_markdown->titol;
	my $content 			= markdown $read_markdown->content;
	my $n_slides 			= $read_markdown->n_slides;
	
	$self->render(
		missatge 	=> "Arxiu markdown",
		titol 		=> $titol,
		content 	=> $content,
		n_slides	=> $n_slides,
	);
}
# }}}

# Show all slides {{{
sub diapos {
	my $self = shift;
	my $id_pres	 = $self->stash('id');
	my $pres  	 = $self->model->pres_id($id_pres);
	my $title		 = $pres->{Presentacio};
	my $n_slides = $pres->{Diapositives};

	$self->render(
		title		 => $title,
		id_pres	 => $id_pres,
		n_slides => $n_slides,
	);
}
# }}}

# Show all slides one slide x page {{{
sub slides {
	my $self = shift;
	my $id_pres	 = $self->stash('id');
	my $pres  	 = $self->model->pres_id($id_pres);
	my $title		 = $pres->{Presentacio};
	my $n_slides = $pres->{Diapositives};

	$self->render(
		title		 => $title,
		id_pres	 => $id_pres,
		n_slides => $n_slides,
	);
}
# }}}

# Update presentations {{{
sub update {
	my $self = shift;
	my $id_pres = $self->req->query_params->param('id_pres');
	my $read_markdown = PresClase::Obj::ReadMarkdown->new( id_pres => $id_pres);
	my $titol = $read_markdown->titol;
	my $curs  = $read_markdown->curs;
	my $content = $read_markdown->content;
	my $n_slides = $read_markdown->n_slides;

	my $contingut = {
    Curs_id       => $curs,
		Presentacio 	=> $titol,
		Diapositives 	=> $n_slides
	};

	# Transform to numeric: 01 -> 1
	$id_pres = $id_pres + 0;
	my $find_pres = $self->model->pres_id($id_pres);
	if (defined $find_pres) {
 		$self->model->pres_update($id_pres, $contingut);
 		$self->model->slides_del($id_pres);
 	} else {
 		my $add_pres   = $self->model->pres_insert($contingut);
 		$id_pres			 = $add_pres->last_insert_id;
 	}
 	my $add_diapos = $self->model->slides_add($id_pres,$content);

	$self->flash( message => "S'ha actualitzat la presentació número $id_pres, de $n_slides diapositives, amb el títol: $titol." );

  my $id_course = $self->model->pres_id($id_pres)->{'Curs_id'};
 	$self->redirect_to("/curs/$id_course");
}
# }}}

1;

# vim: tabstop=2 shiftwidth=2
