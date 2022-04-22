#!/usr/bin/env perl
# use Test::More tests => 3;
use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Printer;
use PresClase::Obj::db;

my $model = PresClase::Obj::db->new->model;

# presentacions {{{

# pres {{{
my $pres = $model->pres->hash;
my $presentacio  = $pres->{Presentacio};
my $diapositives = $pres->{Diapositives};
ok(		$pres->{Diapositives} > 5, 			'Hi han més de 5 diapositives en la primera presentació');
is(		$pres->{id},1,			  			'Estem davant de la presentació 1');
like(	$pres->{Presentacio}, '/00:.Test/', 'En el títol de la primera presentació hi ha >Test<');
# }}}

# n_pres {{{
my $n_pres = $model->n_pres;
ok( $n_pres > 10, 'Hi ha més de 10 presentacions');
# }}}

# pres_id {{{
$pres = $model->pres_id(1);
ok(		$pres->{Diapositives} > 5, 			'Hi han més de 5 diapositives en la primera presentació');
is(		$pres->{id},1,			  			'Estem davant de la presentació 1');
like(	$pres->{Presentacio}, '/00:.Test/', 'En el títol de la primera presentació hi ha >Test<');
# }}}

# pres_update: prova de modificar registre 1 {{{

$model->pres_update(1,{
		Presentacio 	=> 'Esborrat',
		Diapositives 	=> 0
	}
);
$pres = $model->pres_id(1);
is(	$pres->{Diapositives}, 0, 			'Modificat diapositives a 0');
is(	$pres->{id},1,			  			'Estem davant de la presentació 1');
is(	$pres->{Presentacio}, 'Esborrat', 	'En el títol de la primera presentació hi ha >Esborrat<');

$model->pres_update(1,{
		Presentacio 	=> $presentacio,
		Diapositives 	=> $diapositives
	}
);
$pres = $model->pres_id(1);

ok(		$pres->{Diapositives} > 5, 			'Hi han més de 5 diapositives en la primera presentació');
is(		$pres->{id},1,			  			'Estem davant de la presentació 1');
like(	$pres->{Presentacio}, '/00:.Test/', 'En el títol de la primera presentació hi ha >Test<');
# }}}

# }}}

# Slides {{{

# slide_html {{{
my $slide_html = $model->slide_html(1, 1);
like($slide_html, '/div.class=.box.*Title/', 'Llegeix el codi HTML de la primer diapositiva');
# }}}

# slide_exists {{{
my $exist = $model->slide_exist(1 , 1);
ok( $exist eq 1, 'First slide exists');
$exist = $model->slide_exist(1 , 99);
ok( $exist eq 0, 'This slide does not exist');
# }}}

# }}}

# p $slide_html;

done_testing();
