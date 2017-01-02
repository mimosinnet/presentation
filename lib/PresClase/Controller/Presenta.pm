package PresClase::Controller::Presenta;
use Mojo::Base 'Mojolicious::Controller';
use PresClase::Objects::ReadMarkdown;

# List presentations {{{
sub llista_pres {
	my $self = shift;
	my @dirs = glob("public/md/*");

	# get the last item of the path 
	my @dir;
	foreach my $dir (@dirs) {
		my @paths = split(/\//,$dir);
		push @dir, pop @paths;
	}

	my $n_pres_in_db = $self->m_pres->count_pres;

	$self->render(
		title => "Llista de Presentacions",
		n_pres_in_db => $n_pres_in_db,
		pres	=> \@dir,
	);
}
# }}}

# Show slide {{{
sub presenta {
	my $self = shift;
	my $id_pres	 = $self->stash('id');
	my $id_diapo = $self->stash('diapo');

	$self->render(
		id_pres			=> $id_pres,
		id_diapo		=> $id_diapo
	);
}
# }}}

# Show markdown file {{{
sub show_markdown {
	my $self = shift;
	my $id_pres	 = $self->stash('id');
	my $read_markdown = PresClase::Objects::ReadMarkdown->new( id_pres => $id_pres);
	my $titol = $read_markdown->titol;
	my $content = $read_markdown->content;
	my $n_diapos = $read_markdown->n_diapos;
	
	$self->render(
		missatge => "Arxiu markdown",
		titol => $titol,
		content => $content,
		n_diapos => $n_diapos,
	);
}
# }}}

# Show all slides {{{
sub diapos {
	my $self = shift;
	my $id_pres	 = $self->stash('id');
	my $pres  	 = $self->m_pres->find_pres($id_pres);
	my $title		 = $pres->presentacio;
	my $n_diapos = $pres->diapositives;

	$self->render(
		title		 => $title,
		id_pres	 => $id_pres,
		n_diapos => $n_diapos,
	);
}
# }}}

# Update presentations {{{
sub update {
	my $self = shift;
	my $id_pres = $self->req->query_params->param('id_pres');
	my $read_markdown = PresClase::Objects::ReadMarkdown->new( id_pres => $id_pres);
	my $titol = $read_markdown->titol;
	my $content = $read_markdown->content;
	my $n_diapos = $read_markdown->n_diapos;

	# Transform in numeric form: 01 -> 1
	$id_pres = $id_pres + 0;
	my $find_pres_rs = $self->m_pres->find_pres($id_pres);
	if (defined $find_pres_rs) {
 		$self->m_pres->update_pres($id_pres,$titol,$n_diapos);
 		$self->m_pres->del_diapos($id_pres);
 	} else {
 		my $add_pres   = $self->m_pres->add_pres($titol,$n_diapos);
 		$id_pres			 = $add_pres->id;
 	}
 	my $add_diapos = $self->m_pres->add_diapos($id_pres,$content);

	$self->flash( message => "S'ha actualitzat la presentació número $id_pres, de $n_diapos diapositives, amb el títol: $titol." );
 	$self->redirect_to('/llista_pres');
}
# }}}

1;

# vim: tabstop=2 shiftwidth=2