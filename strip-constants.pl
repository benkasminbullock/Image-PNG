#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use autodie;
use FindBin;
use Template;
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
                         \((?:\(png_.*?\))?[^\)]+\)
                     )
                    /gxsm) {
        my ($macro, $value) = ($1, $2, $3);
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

my $output_file = "$FindBin::Bin/lib/File/PNG/Const.pm";

my $tt = Template->new (
    INCLUDE_PATH => ['tmpl'],
)
    or die "". Template->error ();
my %vars;
$vars{macros} = \@macros;
$tt->process ('Const.pm.tmpl', \%vars, $output_file)
    or die "" . $tt->error ();
exit;

