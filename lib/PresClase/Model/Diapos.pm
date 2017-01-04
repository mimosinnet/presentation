package PresClase::Model::Diapos;
use Mojo::Base -base;
use Text::Markdown qw{ markdown };

has 'db';

# show presentations {{{
sub show_pres {
	my ($self) = @_;
	return $self->db->resultset('Presentacio');
}
# }}}

# find {{{
sub find_pres {
	my ($self, $id_pres) = @_;
	return $self->db->resultset('Presentacio')->find({ id => $id_pres  });
}

sub find_diapo {
	my ($self, $id_pres, $id_diapo) = @_;
	return $self->db->resultset('Diapositiva')->find(
		{
			'numero' => $id_diapo,
			'presentacio' => $id_pres
		}
	) || "undef: presentation $id_pres, slyde: $id_diapo";
}

# }}} 

# count {{{
sub count_pres {
	my $self = shift;
	return $self->db->resultset('Presentacio')->count;
}

# }}}

# add registers {{{
sub add_pres {
	my ($self, $titol, $diapos) = @_;
	return $self->db->resultset('Presentacio')->create({
			presentacio => $titol,
			diapositives => $diapos
		});
}

sub add_diapos {
	my ($self, $id_pres, $content) = @_;
	my $numero = 0;
	foreach my $diapositiva (split /^-----.*\n/m, $content) {
		$numero++;
		my $background	= "none";
		# If the first line is an image, we use it as the background
		if ( $diapositiva =~ /^!\[alt_text\](.*)/n ) {
			($background)  = ( $diapositiva =~  /!\[alt_text\]\((.*)\)/ );
			$diapositiva = $diapositiva =~ s/\s*!\[alt_text\].*//r ;
		}

		$self->db->resultset('Diapositiva')->create({
			numero 			=> $numero,
			diapositiva => markdown($diapositiva),
			presentacio => $id_pres,
			background 	=> $background
		});
	}
	return $numero;
}
# }}}

# update registers {{{
sub update_pres {
	my ($self, $id, $titol, $diapos) = @_;
	return $self->db->resultset('Presentacio')->find({ id => $id })->update({
			presentacio => $titol,
			diapositives => $diapos
		});
}

# delete registers {{{
sub del_diapos {
	my ($self, $pres_id) = @_;
	return $self->db->resultset('Diapositiva')->search({ presentacio => $pres_id })->delete;
}
# }}}

# }}}

1;

# vim: tabstop=2 shiftwidth=2
