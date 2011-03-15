use strict;
use warnings;
use ExtUtils::MakeMaker;
use ExtUtils::Constant;

# This Makefile.PL uses $Config{ldflags} and $Config{ccflags} in the
# test compilation of a program which links against libpng.

use Config qw/%Config/;

# If the test compilation doesn't work, edit the following two lines
# to point to your libpng library's location and the location of the
# file "png.h".

my $png_lib_dir;
my $png_include_dir;

my $inc = '';
if ($png_include_dir) {
    $inc = "-I $png_include_dir";
}

my $libs = '-lpng';
if ($png_lib_dir) {
    $libs = "-L $png_lib_dir $libs";
}

# A minimal C program to test compilation and running.

my $test_c = <<EOF;
#include "png.h"
int main ()
{
   png_uint_32 libpng_vn = png_access_version_number();
   return 0;
}
EOF

# The name of our test program.

my $exe_file_name = 'png-compile-test';
my $c_file_name = "$exe_file_name.c";

# Booleans which record whether our test program could be compiled and
# run. The default is false.

my $compile_ok;
my $run_ok;

if (! -f $c_file_name && ! -f $exe_file_name) {
    # Get $ldflags and $ccflags from Config.pm.
    my $ldflags = $Config{ldflags};
#    my $ccflags;
    my $ccflags = $Config{ccflags};
    open my $output, ">", $c_file_name
        or die "Error opening file '$c_file_name' for writing: $!";
    print $output $test_c;
    close $output
        or die "Error closing file '$c_file_name': $!";
    $compile_ok =
        (system ("cc $ccflags $inc -o $exe_file_name $c_file_name $ldflags $libs") == 0);
    if ($compile_ok) {
        $run_ok = 
            (system ("./$exe_file_name") == 0);
    }
    for my $file ($exe_file_name, $c_file_name) {
        if (-f $file) {
            unlink $file
                or warn "Sorry I could not delete a temporary file '$file' which I made. Please delete it yourself.\n";
        }
    }
}
else {
    print <<'EOF';
 _____ _ _                                   
|  ___(_) | ___   _ __   __ _ _ __ ___   ___ 
| |_  | | |/ _ \ | '_ \ / _` | '_ ` _ \ / _ \
|  _| | | |  __/ | | | | (_| | | | | | |  __/
|_|   |_|_|\___| |_| |_|\__,_|_| |_| |_|\___|
                                           
           _ _ _     _             
  ___ ___ | | (_)___(_) ___  _ __  
 / __/ _ \| | | / __| |/ _ \| '_ \ 
| (_| (_) | | | \__ \ | (_) | | | |
 \___\___/|_|_|_|___/_|\___/|_| |_|
                                   
EOF
    print <<"EOF";
My compilation test failed due to existing files called one or the
other of '$c_file_name' or '$exe_file_name'. I want to use these
names. Please edit Makefile.PL to make me use different names, or
rename the existing files.
EOF
    exit;
}

if (! $compile_ok || ! $run_ok) {
    print <<'EOF';
 _ _ _                                     _      __                       _ 
| (_) |__  _ __  _ __   __ _   _ __   ___ | |_   / _| ___  _   _ _ __   __| |
| | | '_ \| '_ \| '_ \ / _` | | '_ \ / _ \| __| | |_ / _ \| | | | '_ \ / _` |
| | | |_) | |_) | | | | (_| | | | | | (_) | |_  |  _| (_) | |_| | | | | (_| |
|_|_|_.__/| .__/|_| |_|\__, | |_| |_|\___/ \__| |_|  \___/ \__,_|_| |_|\__,_|
          |_|          |___/                                                 

I tried to compile and run a small test program in C to see if I could
#include the libpng header file "png.h" and link to the library
"libpng". Somehow or other this didn't work out. If you don't have
libpng on your system, sorry but you need to install it to use this
module. If you think you have libpng on your system, please edit the
file "Makefile.PL" and run "perl Makefile.PL" again. The relevant
lines are right at the top of the file,

my $png_lib_dir;
my $png_include_dir;

Edit these lines to wherever your libpng and png.h files
respectively are to be found, for example

my $png_lib_dir = '/some/strange/directory';
my $png_include_dir = '/somewhere/nobody/knows';

Then run "perl Makefile.PL" again. If you don't see this message, you
are alright.
EOF
    exit;
}

WriteMakefile (
    NAME         => 'File::PNG',
    VERSION_FROM => 'lib/File/PNG.pm',
    OBJECT       => 'PNG.o perl-libpng.o',
    LIBS         => $libs,
    INC          => $inc,
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
