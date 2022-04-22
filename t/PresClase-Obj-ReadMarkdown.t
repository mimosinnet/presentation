#!/usr/bin/env perl
# Test PresClase::Objects::ReadMarkdown 
use Modern::Perl;
use Test::More tests => 4;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use PresClase::Obj::ReadMarkdown;
use Mojo::Util qw/ trim  /;
use Mojo::File;

my $slide  = PresClase::Obj::ReadMarkdown->new( id_pres => '01' );
my $file	 = Mojo::File->new(Cwd::getcwd . '/public/md/01/Config.txt')->slurp;
my $title  = $file =~ /Titol:(.*)/ ? $1 : die "Title not defined in $file";
my $course = $file =~ /Curs:(.*)/ ? $1 : die "Course not defined in $file";
$course = sprintf('%02d',$course);

is( $slide->titol, trim $title, "Reads Title from Config.txt" );
like( $slide->content, qr/This is the Title/, "Reads the silide" );
ok( $slide->n_slides > 5, 'First presentation has more than 5 slides');
is( $slide->curs, $course, 'Firs presentation is on course 1' );

done_testing();
