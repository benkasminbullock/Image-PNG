#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use FindBin '$Bin';
use autodie;
use lib '../blib/arch';
use lib '../blib/lib';
use File::PNG;

#my $file_name = "$Bin/guffin-downloaded.png";
my $file_name = "$Bin/tantei-san.png";
my $png = File::PNG::create_read_struct ();
open my $file, "<:raw", $file_name;
File::PNG::init_io ($png, $file);
my $info = File::PNG::create_info_struct ($png);
#print "Reading PNG.\n";
File::PNG::read_png ($png, $info);
#print "Getting rows.\n";
my $rows = File::PNG::get_rows ($png, $info);
close $file;
#printf "There are %d rows.\n", scalar (@$rows); 
#exit;
my @averages;
my $scale = 12;
my $rcount = 0;
for my $row (@$rows) {
    $rcount++;
    my @av_row;
    my $i;
#    print length $row, "\n";
    for ($i = 0; $i < 2*(length $row); $i++) {
#        for my $rgba (0..3) {
            $averages[$rcount/$scale][$i/$scale] += ord (substr ($row, $i/2, 1));
#        }
    }
#    print "\n";
#    last;
}
#printf "There are %d rows in averages.\n", scalar (@averages);
for my $i (0..$#averages) {
    my @row = @{$averages[$i]};
    for my $j (0..$#row) {
        if ($row[$j]    > (8000*$scale)/6) {
            printf " ";
        }
        elsif ($row[$j] > (7000*$scale)/6) {
            printf ".";
        }
        elsif ($row[$j] > (6000*$scale)/6) {
            print ":";
        }
        elsif ($row[$j] > (5000*$scale)/6) {
            print "-";
        }
        elsif ($row[$j] > (4000*$scale)/6) {
            print "*";
        }
        elsif ($row[$j] > (3000*$scale)/6) {
            print "%";
        }
        elsif ($row[$j] > (2000*$scale)/6) {
            print "X";
        }
        elsif ($row[$j] > (1000*$scale)/6) {
            print "#";
        }
        else {
            print "@";
        }
    }
    print "\n";
}
