use strict;
use warnings;
use ExtUtils::MakeMaker;
use ExtUtils::Constant;

WriteMakefile (
    NAME => 'File::PNG',
    VERSION_FROM => 'lib/File/PNG.pm',
    OBJECT => 'PNG.o perl-libpng.o',
    LIBS => ['-lpng'],
);

my @names = (qw());

ExtUtils::Constant::WriteConstants(
    NAME         => 'File::PNG',
    NAMES        => \@names,
    DEFAULT_TYPE => 'IV',
    C_FILE       => 'const-c.inc',
    XS_FILE      => 'const-xs.inc',
);

# The following subroutine adds extra necessary rules to the end of
# "Makefile". See
# http://search.cpan.org/dist/ExtUtils-MakeMaker/lib/ExtUtils/MakeMaker.pm#Overriding_MakeMaker_Methods

sub MY::postamble
{
    my $cfunctions_build = <<EOF;
PNG.o: perl-libpng.h

perl-libpng.h:  perl-libpng.c
	cfunctions -in perl-libpng.c
EOF
    return $cfunctions_build;
}
