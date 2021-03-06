#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;
use lib '/home/ben/projects/Image-PNG/blib/lib';
use lib '/home/ben/projects/Image-PNG/blib/arch';
use Image::PNG::Libpng ':all';
use Image::PNG::Const ':all';
my $file = 'banner_green_servers.png';
open my $input, "<:raw", $file;
my $png = create_read_struct ();
print "OK 0\n";
set_verbosity ($png, 1);
print "OK -1\n";
#set_keep_unknown_chunks ($png, 3, [qw/mkBT prVW/]);
set_keep_unknown_chunks ($png, 3);
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
    print "name: ", $chunk->{name}, " length: ", length $chunk->{data}, "\n";
}
print "OK 6\n";
