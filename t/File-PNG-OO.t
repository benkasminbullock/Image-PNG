
use warnings;
use strict;
use FindBin;
use Test::More tests => 5;
use_ok ("File::PNG::OO");

use File::PNG::OO;

my $png = File::PNG::OO->new ();
my $file = "$FindBin::Bin/test.png";
$png->read_file ($file);
ok ($png->width () == 100, "oo-width");
ok ($png->height () == 100, "oo-height");
ok ($png->color_type () eq 'RGB', "oo colour type");
#print $png->bit_depth (), "\n";
ok ($png->bit_depth () == 8, "oo bit depth");
