#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use lib '../blib/arch';
use lib '../blib/lib';
use Image::PNG::Libpng ':all';

my $png = create_write_struct ();
print "a\n";
set_tIME ($png);
print "b\n";
set_tIME ($png, {year => 2010});
print "c\n";

