#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use lib '../blib/arch';
use lib '../blib/lib';
use Image::PNG qw/display_text/;
use Image::PNG::Const qw/:all/;
use FindBin;

print "\n";
my $png = Image::PNG->new ({file => "$FindBin::Bin/guffin-downloaded.png"});
printf "%d x %d %s %d\n", $png->width, $png->height, $png->color_type, $png->bit_depth;
my @text = $png->text;
for my $chunk (@text) {
    display_text ($chunk);
}
my $rows = $png->rows ();
my $rowbytes = $png->rowbytes;
print "There are $rowbytes bytes in the rows.\n";

