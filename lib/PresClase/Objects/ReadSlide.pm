package PresClase::Objects::ReadSlide;
# Gets database information on Presentation and Slide from id_pres and id_slide
use Mojo::Base -base;
use PresClase::Schema;
use PresClase::Model::Slides;
use Text::Markdown qw{ markdown };

has m_pres => sub {
	my $self = shift;
	my $db = PresClase::Schema->connect('dbi:SQLite:dbname=data/presentacio.db', '', '', 
		{sqlite_unicode => 1 } 
	) || die "Cannot connect";
	return PresClase::Model::Slides->new(db => $db); 
};

has 'id_pres';
has 'id_slide';

# Information on presentation {{{
has 'presentation' => sub {
	my $self = shift;
	return $self->m_pres->find_pres( $self->id_pres );
};

has 'n_slides' => sub {
	my $self = shift;
	return $self->presentation->diapositives;
};

has 'title' => sub {
	my $self = shift;
	return $self->presentation->presentacio;
};
# }}}

has 'slide' => sub {
	my $self = shift;
	return $self->m_pres->find_diapo( $self->id_pres, $self->id_slide);
};

has 'diapositiva' => sub {
	my $self = shift;
	return markdown $self->slide->diapositiva;
};
has 'background' => sub {
		my $self = shift;
		return $self->slide->background;
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

# Set div depending on value of $background {{{
sub div { 
	my $self = shift;
	my $background = $self->background;
	my ($div_box, $div_contingut);
	if ( $background eq "none" ) {
		$div_box = '<div class="box" style="color: black">';
		$div_contingut = '<div class="contingut">';
	} else {
		$div_box = '<div class="box" style="background-image: url(' . $background . '); color: black">';
		$div_contingut = '<div class="contingut" style="color: yellow; background: rgba(0, 0, 0, 0.8);">';
	}
	return ($div_box, $div_contingut);
};

# }}}

1;
