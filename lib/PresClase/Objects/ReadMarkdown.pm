package PresClase::Objects::ReadMarkdown;
use Mojo::Base -base;
use Config::Simple;
use Mojo::Util qw( trim slurp decode );

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
		return trim decode 'UTF-8', $cfg->param('Titol');
	};
has 'content' => sub {
		my $self = shift;
		my $id_pres = $self->id_pres;
		return "Error in /md/$id_pres/Presentacio.md" unless -e "public/md/$id_pres/Presentacio.md";
		return trim decode 'UTF-8', slurp "public/md/$id_pres/Presentacio.md";
	};
has 'n_slides' => sub {
		my $self = shift;
		my $n_slides = split /\n-----.*\n/, $self->content;
		return $n_slides;
	};

1;

__END__

=head1 NAME

PresClase::Objects::ReadMarkdown - base class for reading Markdown file

=head1 SYNOPSIS

	# It reads the files 'public/md/01/Config.txt' and 'public/md/01/Presentacio.md'
	
	use 'PresClase::Objects::ReadMarkdown';
	my $slide = PresClase::Objects::ReadMarkdown->new( id_pres => '01' );

	my $title_of_presentation = $slide->titol;
	my $markdown_file = $slide->content;
	my $number_of_slides = $slide->n_slides;

=head1 DESCRIPTION

The object represents the content of the markdown file and reads the associated configuration. 

=head1 ATTRIBUTES

=head2 C<id_pres>

Identification of the presentation. It assumes a number of presentations from 01 to 99.

=head2 C<cfg>

An instance of Config::Simple for internal use. 

=head2 C<>
