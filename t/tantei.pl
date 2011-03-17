#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use lib '../blib/arch';
use lib '../blib/lib';
use File::PNG;
my $png = File::PNG->new ();
$png->read_file ('tantei-san-2.png');
printf "%d x %d %s %d\n", $png->width, $png->height, $png->color_type, $png->bit_depth;
my $rows = $png->rows;
my @pixels;
for my $i (0..$png->height - 1) {
#    print length $rows->[$i], "\n";
    for my $j (0..$png->width - 1) {
        $pixels[$i][$j] = ord substr ($rows->[$i], $j, 1);
    }
}
my $x_size = 60;
my $y_size = 20;
my $x_scale = $x_size / $png->width;
my $y_scale = $y_size / $png->height;
my @ascii_pixels;
my $max = 0;
for my $i (0..$x_size - 1) {
    for my $j (0..$y_size - 1) {
        $ascii_pixels[$j][$i] = 0;
    }
}
for my $i (0..$png->width - 1) {
    my $ascii_x = $i * $x_scale;
    if ($ascii_x > $x_size) {
        die "Over x size";
    }
    for my $j (0..$png->height - 1) {
        my $ascii_y = $j * $y_scale;
        if ($ascii_y > $y_size) {
            die "Over y size";
        }
        my $val = 0;
        $ascii_pixels[$ascii_y][$ascii_x] += $pixels[$j][$i];
        $val = $ascii_pixels[$ascii_y][$ascii_x];
        if ($val > $max) {
            $max = $val;
        }
    }
}
print "Max is $max\n";
my @shades = (' ', ' ', qw/. : - | + = % * & % X @/);
    for my $j (0..$y_size - 1) {
for my $i (0..$x_size - 1) {
        my $offset = (1 - $ascii_pixels[$j][$i]/$max) * $#shades;
#        print "$offset\n";
        my $shading = $shades[$offset];
        print $shading;
    }
    print "\n";
}



