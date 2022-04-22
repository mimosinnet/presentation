use FindBin qw($Bin);
use lib "$Bin/../lib";
use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('PresClase');
$t->get_ok('/')->status_is(200)->content_like(qr/Presentacions/i);

done_testing();
