package PresClase::Obj::ReadSlide;
# Gets database information on Presentation and Slide from id_pres and id_slide
use Mojo::Base -base;
use PresClase::Obj::db;

has model => sub { return PresClase::Obj::db->new->model };

has 'id_pres';
has 'id_slide';

# Information on presentation {{{
has 'presentation' => sub {
	my $self = shift;
	return $self->model->pres_id( $self->id_pres );
};

has 'n_slides' => sub {
	my $self = shift;
	return $self->presentation->{Diapositives};
};

has 'title' => sub {
	my $self = shift;
	return $self->presentation->{Presentacio};
};
# }}}

has 'html_code' => sub {
	my $self = shift;
	return $self->model->slide_html( $self->id_pres, $self->id_slide );
};

sub position {
	my $self = shift;
	my $id_slide = $self->id_slide;
	my $n_slides = $self->n_slides;
	my $next = $id_slide + 1;
	$next		 = 1 if $next > $n_slides;
	my $prev = $id_slide - 1;
	$prev		 = $n_slides if $prev == 0;
	return ($prev, $next);
}

# }}}

1;
