#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;
use lib '../blib/lib';
use lib '../blib/arch';
use Image::PNG::Libpng ':all';
use Image::PNG::Const ':all';

my $file;
if ($ARGV[0]) {
$file = $ARGV[0];
}
else {
    die "No input.\n";
}
open my $input, "<:raw", $file;
my $png = create_read_struct ();
init_io ($png, $input);
print "Reading file '$file':\n";
read_png ($png);
my $IHDR = get_IHDR ($png);
for my $k (keys %$IHDR) {
    print "$k -> $IHDR->{$k}.\n";
}
my $valid = get_valid ($png);
for my $k (keys %$valid) {
    if ($valid->{$k}) {
        print "Valid $k chunk\n";
    }
}
print "ok\n";
my $rows = get_rows ($png);
print "ok\n";
close $input;
my $text = '';
for my $row (@$rows) {
    $text .= $row;
}
$text =~ s/0123456789.*$//;
open my $output, ">:raw", "reassembled-file.txt";
print $output $text;
close $output;
