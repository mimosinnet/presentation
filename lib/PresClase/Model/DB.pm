package PresClase::Model::DB;
use Mojo::Base -base;
use Text::Markdown qw{ markdown };

has 'sqlite';

# https://metacpan.org/pod/SQL::Abstract
# select($source, $fields, $where, $order)

# cursos {{{
sub cursos {
  my $self = shift;
  return $self->sqlite->db->select('cursos', undef, undef, 'Curs');
}

sub curs {
  my ($self, $id) = @_;
  return $self->sqlite->db->select('cursos', 'Curs', { id => $id })->hash->{'Curs'};
}

# }}}

# presentacions {{{
sub pres {
  my $self = shift;
  return $self->sqlite->db->select('presentacio', undef, undef, 'Presentacio');
}

sub pres_curs {
  my ($self, $id) = @_;
  return $self->sqlite->db->select('presentacio', undef, { Curs_id => $id }, 'Presentacio');
}


# número de presentacions
sub n_pres {
  my $self = shift;
	return $self->sqlite->db->query("SELECT count(*) as count FROM presentacio")->hash->{'count'};
}

# presentació a partir del id
sub pres_id {
	my ($self, $id) = @_;
	return $self->sqlite->db->select('presentacio',undef, { id => $id})->hash;
}

# actualitza informació de la presentació
sub pres_update {
	my ($self, $id, $contingut) = @_;
	return $self->sqlite->db->update('presentacio',$contingut, { id => $id});
}

# insertar presentació
sub pres_insert {
	my ($self, $contingut) = @_;
	return $self->sqlite->db->insert('presentacio',$contingut);
}

# }}}

# slides {{{

# get html_code
sub slide_html {
	my ($self, $pres, $slide) = @_;
	return $self->sqlite->db->select('diapositiva', undef, { presentacio => $pres, numero => $slide })->hash->{'html_code'};
}

# delete all slides from presentation
sub slides_del {
	my ($self, $pres) = @_;
	return $self->sqlite->db->delete('diapositiva', { presentacio => $pres } );
}

# check if slide exists
sub slide_exist {
  my ($self, $pres, $slide) = @_;
	return $self->sqlite->db->query("SELECT count(*) as count FROM diapositiva WHERE presentacio = '$pres' AND numero = '$slide' ")->hash->{'count'};
}

# slides_add {{{
sub slides_add {
	my ($self, $id_pres, $content) = @_;
	my $numero = 0;
	# Add contents for each slide {{{
	foreach my $diapositiva (split /\n---.*\n/m, $content) {
		$numero++;
		my $background	= "";
		my $style				= "";
		my $div_box = '<div class="box" style="color: black">';

		# If the frist line defines a style, we set the style
		if ( $diapositiva =~ /^\[style\]/n ) {
			($style)  		  = ( $diapositiva =~  /\[style\]:\s+\#\s+\((.*)\)/ );
			$diapositiva 		=   $diapositiva =~ s/^\[style\].*\n//r ;
		}
		# If the second (or first) line is an image, we use it as the background
		if ( $diapositiva =~ /^!\[alt_text\]/n ) {
			($background)  = ( $diapositiva =~  /!\[alt_text\]\((.*)\)/ );
			$diapositiva = $diapositiva =~ s/^!\[alt_text\].*\n//r ;
			$div_box = '<div class="box" style="background-image: url(' . $background . '); color: black">';
			$style .= "color: yellow; background: rgba(0, 0, 0, 0.8);"; 
		}

		my $div_contingut = '<div class="contingut" style="' . $style . '">';
		my $contingut		  = markdown $diapositiva;
		my $html_code   	= $div_box . $div_contingut . $contingut . '</div></div>';

		# The content of the slide (diapositiva) is saved as markdown (diapositiva) and html (html_code)
		$self->sqlite->db->insert('diapositiva', {
			numero 			=> $numero,
			presentacio => $id_pres,
			html_code		=> $html_code,
		});
	} 
	# }}}
	return $numero;
}
# }}}


# }}}

1;

# vim: tabstop=2 shiftwidth=2
