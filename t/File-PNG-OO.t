
use warnings;
use strict;
use FindBin;
use Test::More tests => 3;
use_ok ("File::PNG::OO");

use File::PNG::OO;

my $png = File::PNG::OO->new ();
my $file = "$FindBin::Bin/test.png";
$png->read_file ($file);
ok ($png->width () == 100, "oo-width");
ok ($png->height () == 100, "oo-height");

