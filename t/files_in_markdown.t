#!/usr/bin/env perl
# Description {{{
# Check if there exist the file structure
# 	/public/md/_presentation_/Presentacio.md
# 	/public/md/_presentation_/Config.txt
# 	/public/md/_presentation_/_link_to_media
# 	content of link_to_media
# 	/public/media/_presentation_
# Check if number of diapos is the same in md and db
# }}}

use Cwd qw( getcwd );
use File::Find::Rule;
use Modern::Perl;
use File::Basename qw ( fileparse );
use Mojo::Util qw( dumper slurp );
use Test::More;
use PresClase::Objects::ReadSlide;


my $working_dir 	= getcwd;
my $dir_markdown	= "$working_dir/public/md";
my $dir_media			= "$working_dir/public/media";

my $rule = File::Find::Rule->new;
	$rule->directory;
	$rule->maxdepth('1');
	$rule->mindepth('1');
my @dirs = $rule->in($dir_markdown);

plan tests => 6 * scalar @dirs;

foreach my $file (sort @dirs) { 
	my $markdown	= slurp "$file/Presentacio.md";
	my $n_diapos_md = split /\n-----.*\n/, $markdown; 
	my $id_pres = fileparse $file;
	my $dir_media = "$dir_media/" . $id_pres;
	my $diapo = PresClase::Objects::ReadSlide->new( id_pres => $id_pres );
	my $n_diapos_db = $diapo->n_diapos;

	ok( -f -r "$file/Presentacio.md", "$file/Presentacio.md");
	ok( -f -r "$file/Config.txt", "$file/Config.txt");
	ok( -l		"$file/media", "$file/media" );
	ok( readlink "$file/media" eq "../../media", "link $file/media");
	ok( -d -r  $dir_media, $dir_media);
	is( $n_diapos_db, $n_diapos_md, "Number of slides presentation $id_pres: coincidence markdown and db");
};

