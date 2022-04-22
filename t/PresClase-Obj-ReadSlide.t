#!/usr/bin/env perl
use Modern::Perl;
use Test::More;
# tests => 3;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Printer;
use PresClase::Obj::ReadSlide;

my $slide  = PresClase::Obj::ReadSlide->new( id_pres => 1, id_slide => 1 );
my ($prev, $next) = $slide->position;

ok(		$slide->n_slides > 5, 			'Hi han més de 5 diapositives en la primera presentació');
like(	$slide->title, '/00:.Test/', 	'En el títol de la primera presentació hi ha >Test<');
like( 	$slide->html_code, '/div.class=.box.*Title/', "Reads the html_code" );
is(		$next, 2, 						'Next slide is number 2');
ok(		$prev > 5, 						'Last slide is greter than 5'); 

# p $prev;

done_testing();
