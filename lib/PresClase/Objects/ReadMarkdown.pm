package PresClase::Objects::ReadMarkdown;
use Mojo::Base -base;
use Config::Simple;
use Mojo::Util qw( trim slurp decode);

has 'id_pres';
has 'cfg' => sub {
		my $self = shift;
		my $id_pres = $self->id_pres;
		return new Config::Simple("public/md/$id_pres/Config.txt");
	};
has 'titol' => sub {
		my $self = shift;
		my $id_pres = $self->id_pres;
		return "Error in /md/$id_pres/Config.txt" unless defined $self->cfg;
		my $cfg		= $self->cfg;
		return decode 'UTF-8', $cfg->param('Titol');
	};
has 'content' => sub {
		my $self = shift;
		my $id_pres = $self->id_pres;
		return "Error in /md/$id_pres/Presentacio.md" unless -e "public/md/$id_pres/Presentacio.md";
		return trim decode 'UTF-8', slurp "public/md/$id_pres/Presentacio.md";
	};
has 'n_diapos' => sub {
		my $self = shift;
		my $n_diapos = () = $self->content =~ /^-----/mg;
		return $n_diapos+1;
	};

1;
