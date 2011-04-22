use warnings;
use strict;
use FindBin;
use Image::PNG::Libpng ':all';
use Test::More tests => 9;


my $png = create_read_struct ();
open my $fh, "<:raw", "$FindBin::Bin/bgyn6a16.png" or die $!;
init_io ($png, $fh);
read_png ($png);
close $fh or die $!;
my $bg = get_bKGD ($png);
ok ($bg, "get background");
my %col = (
    green => 65535,
    index => 0,
    blue => 0,
    gray => 0,
    red => 65535,
);

for my $col (keys %col) {
    ok ($bg->{$col} == $col{$col}, "$col background");
}
my $valid = get_valid ($png);
my @expect = qw/IDAT bKGD gAMA/;
for my $k (@expect) {
    ok ($valid->{$k}, "Valid $k");
}
