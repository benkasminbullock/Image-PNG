#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;

use lib '../blib/lib';
use lib '../blib/arch';
use Image::PNG::Libpng ':all';
use Image::PNG::Const ':all';

my $size = 100;

my $png = create_write_struct ();
my @rows;
for my $y (0..$size - 1) {
    for my $x (0..$size -1) {
        my $red = (255/$size) * $x;
        my $green = (255/$size) * $y;
        my $blue = (2 * $size - $x - $y) * 255 / ($size * 2);
        $rows[$y] .= pack "CCC", $red, $green, $blue;
    }
}
my %IHDR = (
    width => $size,
    height => $size,
    color_type => PNG_COLOR_TYPE_RGB,
    bit_depth => 8,
);
set_IHDR ($png, \%IHDR);
set_rows ($png, \@rows);
my $img = write_to_scalar ($png);
print length $img;
print "\n";
open my $output, ">:raw", "test-write-scalar.png";
print $output $img;
close $output;
exit;


