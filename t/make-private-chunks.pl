#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;

use lib '../blib/lib';
use lib '../blib/arch';
use Image::PNG::Libpng ':all';
use Image::PNG::Const ':all';

my $size = 10;
my $png = create_write_struct ();
my @rows;
for my $y (0..$size - 1) {
    my $row = '';
    for my $x (0..$size - 1) {
        $row .= '*';
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
print "OK\n";
set_unknown_chunks ($png, 
                    [{
                        location => PNG_HAVE_IHDR,
                        name => 'fART',
                        data => 'flatulent flabby fart arse'
                    },]);
print "OK\n";
open my $output, ">:raw", "poo.png";
init_io ($png, $output);
write_png ($png);
close $output;



