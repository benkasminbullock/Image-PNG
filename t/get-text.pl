#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use LWP::Simple;
use URI::Escape;
use lib '../blib/lib';
use lib '../blib/arch';
use Image::PNG::Libpng ':all';
my $kanji = '蟹';
my $image = get ('http://mikan/kanjivg/memory.cgi?k=' . uri_escape ($kanji));
my $png = create_read_struct ();
read_from_scalar ($png, $image);
my $text = Image::PNG::Libpng::get_text ($png);

#print ref $text, "\n";
for my $chunk (@$text) {
    for my $k (keys %$chunk) {
        if ($chunk->{$k}) {
            printf ("%s:\"%s\"\n", $k, $chunk->{$k});
        }
    }
}
