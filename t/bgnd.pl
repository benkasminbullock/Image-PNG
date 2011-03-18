#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;
use lib '../blib/arch';
use lib '../blib/lib';
use Image::PNG::Libpng ':all';

my $png = create_read_struct ();
open my $fh, "<:raw", 'bgyn6a16.png';
init_io ($png, $fh);
read_png ($png);
close $fh;
my $bg = get_bKGD ($png);
for my $k (keys %$bg) {
    print "$k $bg->{$k}\n";
}
my $valid = get_valid ($png);
for my $k (keys %$valid) {
    print "$k $valid->{$k}\n";
}
my $png2 = create_read_struct ();
open my $fh2, "<:raw", 'tantei-san.png';
init_io ($png2, $fh2);
read_png ($png2);
close $fh2;
my $bg = get_bKGD ($png2);
print ref $bg, "\n";
for my $k (keys %$bg) {
    print "$k $bg->{$k}\n";
}
my $valid2 = get_valid ($png2);
for my $k (keys %$valid2) {
    print "$k $valid2->{$k}\n";
}


