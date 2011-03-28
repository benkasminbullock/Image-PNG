#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;

use lib '../blib/lib';
use lib '../blib/arch';
use Image::PNG::Libpng ':all';
use Image::PNG::Const ':all';

my $size = 1000;

print "length = ",length $str, "\n";
my $nrows = int (length ($str) / $size) + 1;
print "n rows = $nrows\n";
my $png = create_write_struct ();
my @rows;
for my $y (0..$nrows - 1) {
    my $put = substr ($str, $y * $size, ($y + 1) * $size);
    if (length $put < $size) {
        $put .= '*' x ($size - length $put);
    }
    push @rows, $put;
}
my %IHDR = (
    width => $size,
    height => $nrows,
    color_type => PNG_COLOR_TYPE_GRAY,
    bit_depth => 8,
);
set_IHDR ($png, \%IHDR);
set_rows ($png, \@rows);
open my $output, ">:raw", "poo.png";
init_io ($png, $output);
write_png ($png);
close $output;



