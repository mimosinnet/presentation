#!/usr/bin/env perl
# Test PresClase::Objects::ReadMarkdown 

use Modern::Perl;
use Test::More tests => 3;
use PresClase::Objects::ReadMarkdown;
use Mojo::Util qw ( slurp trim );

my $slide  = PresClase::Objects::ReadMarkdown->new( id_pres => '01' );
my $file	 = slurp Cwd::getcwd . '/public/md/01/Config.txt';
my $title = $file =~ /Titol:(.*)$/ ? $1 : die "Title not defined in $file";

is( $slide->titol, trim $title, "Reads Title from Config.txt" );
like( $slide->content, qr/This is the Title/, "Reads the silide" );
is( $slide->n_slides, "5", "Correct number of slides" );

