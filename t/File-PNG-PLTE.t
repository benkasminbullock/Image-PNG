use warnings;
use strict;
use FindBin;
use autodie;
use lib '../blib/arch';
use lib '../blib/lib';
use File::PNG;

#my $file_name = "$FindBin::Bin/guffin-downloaded.png";
my $file_name = "$FindBin::Bin/tantei-san.png";
my $png = File::PNG::create_read_struct ();
open my $file, "<:raw", $file_name;
File::PNG::init_io ($png, $file);
my $info = File::PNG::create_info_struct ($png);
#print "Reading PNG.\n";
File::PNG::read_png ($png, $info);
#print "Getting rows.\n";
my @colors;
File::PNG::get_PLTE ($png, $info, \@colors);
#exit;
for my $color (@colors) {
    print "Red: $color->{red} green: $color->{green} blue: $color->{blue}\n";
}
close $file;
