#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use lib '../blib/arch';
use lib '../blib/lib';
use File::PNG::OO;
my $png = File::PNG::OO->new ();
$png->read_file ('tantei-san.png');
printf "%d x %d %s %d\n", $png->width, $png->height, $png->color_type, $png->bit_depth;
my $rows = $png->rows;
my @pixels;
for my $i (0..$png->height - 1) {
#    print length $rows->[$i], "\n";
    for my $j (0..$png->width - 1) {
        $pixels[$i][$j] = ord substr ($rows->[$i], $j, 1);
    }
}
