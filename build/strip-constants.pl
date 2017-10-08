#!/home/ben/software/install/bin/perl

# This strips out the constants of png.h and puts them into a Perl
# module.

use warnings;
use strict;
use autodie;
use FindBin '$Bin';
use Template;
BEGIN {
    use FindBin '$Bin';
    use lib "$Bin";
    use ImagePNGBuild;
};
use autodie;
my $verbose = 1;
my $input_file = '/usr/local/include/png.h';
my @macros;
my %macros;
{
    local $/;
    open my $input, "<", $input_file;
    my $text = <$input>;
    close $input;
    while ($text =~ /^\#define\s+
                     (PNG_\w+)\s+
                     (
                         (?:0[xX]|-)?
                         [0-9a-fA-F]+|
                         \w+|
                         \(
                         (?:\(png_.*?\))?[^\)]+
                         \)
                     )
                    /gxsm) {
        my ($macro, $value) = ($1, $2);
        $value =~ s/\(png.*\)//;

        # Now we reject constants which aren't necessary for Perl.

        if ($macro =~ /_LAST$/) {
            next;
        }
        if ($macro =~ /_LIBPNG_/) {
            next;
        }
        if ($macro =~ /_MAX$/) {
            next;
        }

        # The following heebie jeebies turns values of the form (X |
        # Y) into numbers like (1 | 4). It also removes newlines and
        # tidies spaces in the values.

        $macros{$macro} = $value;
        for my $k (keys %macros) {
            $value =~ s/\b$k\b/$macros{$k}/g;
        }
        $value =~ s/\\\n//g;
        $value =~ s/\s+/ /g;
        $macros{$macro} = $value;
        push @macros, {macro => $macro, value => $value};
    }
}

my %config = ImagePNGBuild::read_config;

my $output_file = "$config{submodule_dir}/Const.pm";

my $tt = Template->new (
    ABSOLUTE => 1,
    INCLUDE_PATH => [$config{tmpl_dir}],
)
    or die "". Template->error ();
my %vars;
$vars{macros} = \@macros;
$vars{config} = \%config;
$tt->process ('Const.pm.tmpl', \%vars, $output_file)
    or die "" . $tt->error ();
exit;

