#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use Image::PNG::Libpng ':all';
my $pin = Image::PNG::Libpng::create_read_struct ();
$pin->read_file ('t/with-text.png');
my $pout = Image::PNG::Libpng::create_write_struct ();
$pout->set_IHDR ($pin->get_IHDR ());
$pout->set_text ($pin->get_text ());
$pout->set_rows ($pin->get_rows ());
my $out = 't/with-text-2.png';
$pout->write_file ($out);
my $pcheck = Image::PNG::Libpng::create_read_struct ();
$pcheck->read_file ($out);
    my $text = $pcheck->get_text ();
    if ($text) {
        for my $t (@$text) {
            print "TEXT:\n";
            for my $k (keys %$t) {
                my $v = $t->{$k};
                if (! defined $v) {
                    $v = 'undefined';
                }
                print "$k: $v\n";
            }
            print "\n";
        }
    }
