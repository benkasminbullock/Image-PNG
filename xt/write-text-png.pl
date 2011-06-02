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
set_verbosity ($png, 1);
my @rows;
for my $y (0..$size - 1) {
    my $row = '';
    for my $x (0..$size - 1) {
        $row .= pack "C", int (rand () * 0x100);
    }
    push @rows, $row;
}
my %IHDR = (
    width => $size,
    height => $size,
    color_type => PNG_COLOR_TYPE_GRAY,
    bit_depth => 8,
);
set_IHDR ($png, \%IHDR);
set_rows ($png, \@rows);
set_text (
    $png, 
    [
    {
        compression => PNG_TEXT_COMPRESSION_NONE,
        keyword => "Funky monkey buggy",
        text => "Funky chunky monkey buggy",
    },
    {
        compression => PNG_ITXT_COMPRESSION_zTXt,
        keyword => "Funky monkey buggy",
        text => "すごいばかなおとうさん",
        language_tag => 'ja',
    },
]
);

open my $output, ">:raw", "poo.png";
init_io ($png, $output);
write_png ($png);
close $output;



