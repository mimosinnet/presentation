#!/usr/bin/env perl
# Test PresClase::Objects::ReadMarkdown 

use Modern::Perl;
use Test::More tests => 3;
use PresClase::Objects::ReadMarkdown;

my $slide = PresClase::Objects::ReadMarkdown->new( id_pres => '01' );

is( $slide->titol, "Testing: Title of first presentation", "Reads Title from Config.txt" );
like( $slide->content, qr/This is the Title/, "Reads the silide" );
is( $slide->n_diapos, "5", "Correct number of slides" );

