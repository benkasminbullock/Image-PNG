#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;
use lib '/home/ben/projects/Image-PNG/blib/lib';
use lib '/home/ben/projects/Image-PNG/blib/arch';
use Image::PNG::Libpng ':all';
my $file = 'banner_green_servers.png';
open my $input, "<:raw", $file;
my $png = create_read_struct ();
set_verbosity ($png, 1);
print "OK 1\n";
init_io ($png, $input);
print "OK 2\n";
read_png ($png);
print "OK 3\n";
close $input;
print "OK 4\n";
my $chunks = get_unknown_chunks ($png);
print "OK 5\n";
for my $chunk (@$chunks) {
    print $chunk->{name}, length $chunk->{data}, "\n";
}
print "OK 6\n";
