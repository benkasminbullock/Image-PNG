#!/bin/sh

# This tests the compilation of perl-libpng.c for warnings. Putting
# -Wall into the Makefile.PL under CCFLAGS seems to have a disastrous
# effect, so I compile this separately, with the -I for the Perl stuff
# taken from the output Makefile. If you want to test this then you
# need to edit this.

cc -Wall -I /usr/local/include -I/home/ben/software/install/lib/perl5/5.10.0/i386-freebsd/CORE -c perl-libpng.c

