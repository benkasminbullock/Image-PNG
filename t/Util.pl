#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use lib '../blib/arch';
use lib '../blib/lib';
use autodie;
use Image::PNG::Libpng ':all';
use Image::PNG::Util qw/copy_chunks/;
my @png_files = <*.png>;
for my $png_file (@png_files) {
    if ($png_file =~ /^x/) {
        # Broken PNG files which cause errors
        next;
    }
    print "\nLooking at $png_file.\n";
my $in_png = create_read_struct ();
my $out_png = create_write_struct ();
open my $file, "<:raw", $png_file;
init_io ($in_png, $file);
read_png ($in_png);
copy_chunks ($in_png, $out_png, [qw/all/], 1);
}
#copy_chunks (undef, undef, ['safe'], 1);
