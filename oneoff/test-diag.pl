#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use lib 'build';
use Build;
my $d = Build::libpng_diagnostics ({}, 1);
