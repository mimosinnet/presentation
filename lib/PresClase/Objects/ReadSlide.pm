package PresClase::Objects::ReadSlide;
use Mojo::Base -base;
use PresClase::Schema;
use PresClase::Model::Diapos;

has m_pres => sub {
	my $self = shift;
	my $db = PresClase::Schema->connect('dbi:SQLite:dbname=data/presentacio.db', '', '', 
		{sqlite_unicode => 1 } 
	) || die "Cannot connect";
	return PresClase::Model::Diapos->new(db => $db); 
	};

has 'id_pres';
has 'id_diapo';

# Information on presentation {{{
has 'presentation' => sub {
		my $self = shift;
		return $self->m_pres->find_pres( $self->id_pres );
	};

has 'n_diapos' => sub {
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
		return $self->m_pres->find_diapo( $self->id_pres, $self->id_diapo);
	};

has 'diapositiva' => sub {
		my $self = shift;
		return $self->slide->diapositiva;
	};
has 'background' => sub {
		my $self = shift;
		return $self->slide->background;
	};

has next => sub {
		my $self = shift;
		my $id_diapo = $self->id_diapo;
		my $n_diapos = $self->n_diapos;
		my $next = $id_diapo + 1;
		$next		 = 1 if $next > $n_diapos;
		return $next;
	};

has prev => sub {
		my $self = shift;
		my $id_diapo = $self->id_diapo;
		my $n_diapos = $self->n_diapos;
		my $prev = $id_diapo - 1;
		$prev		 = $n_diapos if $prev == 0;
		return $prev;
	};

# Set div depending on value of $background {{{
has div_box => sub { 
		my $self = shift;
		my $background = $self->background;
		my $div_box;
		if ( $background eq "none" ) {
			$div_box = '<div class="box" style="color: black">';
		} else {
			$div_box = '<div class="box" style="background-image: url(' . $background . '); color: black">';
		}
		return $div_box;
	};

has div_contingut => sub {
		my $self = shift;
		my $background = $self->background;
		my $div_contingut;
		if ( $background eq "none" ) {
			$div_contingut = '<div class="contingut">';
		} else {
			$div_contingut = '<div class="contingut" style="color: yellow; background: rgba(0, 0, 0, 0.8);">';
		}
		return $div_contingut;
	};
# }}}

1;
