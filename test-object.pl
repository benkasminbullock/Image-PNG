#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use lib 'blib/arch';
use lib 'blib/lib';
use Image::PNG::Libpng ':all';

my $png = create_write_struct ();
open my $file, ">:raw", "out.png" or die $!;
$png->init_io ($file);
$png->set_IHDR ({height => 1, width => 1, bit_depth => 1});
$png->set_rows ([0]);
$png->write_png ();
$png->destroy_write_struct ();


