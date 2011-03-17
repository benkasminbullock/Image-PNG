use warnings;
use strict;
use FindBin;
use autodie;
use File::PNG::Libpng;
use Test::More tests => 3;

my $file_name = "$FindBin::Bin/tantei-san.png";
my $png = File::PNG::Libpng::create_read_struct ();
open my $file, "<:raw", $file_name;
File::PNG::Libpng::init_io ($png, $file);
my $info = File::PNG::Libpng::create_info_struct ($png);
#print "Reading PNG.\n";
File::PNG::Libpng::read_png ($png, $info);
#print "Getting rows.\n";
my @colors;
File::PNG::Libpng::get_PLTE ($png, $info, \@colors);
#exit;
#for my $color (@colors) {
#    print "Red: $color->{red} green: $color->{green} blue: $color->{blue}\n";
#}
ok ($colors[10]->{red} == 10);
ok ($colors[20]->{green} == 20);
ok ($colors[200]->{blue} == 200);
close $file;
