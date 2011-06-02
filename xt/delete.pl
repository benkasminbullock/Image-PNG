#!/home/ben/software/install/bin/perl
use warnings;
use strict;

use lib '../blib/arch';
use lib '../blib/lib';

use Image::PNG;

# Delete segments from a PNG image

my $png = Image::PNG->new ({verbosity => 1});

$png->read ('blank.png');
$png->delete (qw/gAMA tEXt cHRM sRGB/);
$png->write ('blank-stripped.png');
