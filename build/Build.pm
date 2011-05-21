# This module is for building the Perl distribution from the
# templates. This module is not one of the installed files of the
# distribution.

package Build;
use warnings;
use strict;
use autodie;
use Carp;
use FindBin;

my $base = "$FindBin::Bin/..";
my $tmpl_dir = "$base/tmpl";

sub read_config
{
    my $config_file = "$tmpl_dir/config";
    my %config;
    open my $config_fh, "<", $config_file;
    while (<$config_fh>) {
        if (/^(\w+):\s*(.*?)\s*$/) {
            $config{$1} = $2;
        } else {
            die "Bad line '$_' in $config_file";
        }
    }
    close $config_fh;
    $config{out_dir} = "$config{base}";
    $config{base_hyphen} = $config{base};
    $config{base_hyphen} =~ s/::/-/g;
    $config{base_underscore} = $config{base};
    $config{base_underscore} =~ s/:/_/g;
    $config{out_dir} =~ s/::/\//g;
#    print "Output directory is $config{out_dir}.\n";
    $config{submodule_dir} = "lib/$config{out_dir}";
    $config{main_module_out} = "lib/$config{out_dir}.pm";
    $config{base_slash} = "$config{out_dir}.pm";
    $config{main_module} = $config{base_slash};
    $config{main_module} =~ s!.*/!!;
    $config{base_dir} = $base;
    $config{tmpl_dir} = $tmpl_dir;
    return %config;
}

sub get_functions
{
    my ($config_ref) = @_;
    if (! $config_ref) {
        croak "No configuration supplied";
    }
    open my $input, "<", "$config_ref->{tmpl_dir}/Libpng.xs.tmpl";
    my @functions;
    while (<$input>) {
        if (/^\S+.*?perl_png_(\w+)\s*\(/) {
            push @functions, $1;
        }
    }
    close $input;
#    print "@functions";
    return \@functions;
}

# Extract a list of diagnostics for the Libpng part of the module for
# use in the documentation.

sub libpng_diagnostics
{
    my ($config_ref, $verbose) = @_;
    my @diagnostics;
    my $text = `cat tmpl/perl-libpng.c.tmpl`;
    while ($text =~ m@
                         # Comment describing the diagnostic
                         (?:/\*\s*((?:[^\*]|\*[^/])+?)\s*\*/)?[\s|\\]+
                         # Diagnostic call
                         perl_png_(warn|error)\s*
                         # First argument is the carry-all
                         \(\s*png\s*,\s*
                         # Text message
                         ((?:"[^"]*"[\s\\]*)+)
                     @xgsm) {
        my $comment = $1;
        my $type = $2;
        my $message = $3;
        $message =~ s/"[\s\\]+"//g;
        $message =~ s/^"(.*)"$/$1/;
        if ($comment) {
            $comment =~ s/[\s|\\]+/ /g;
        }
        if ($verbose) {
            if ($comment) {
                print "$comment\n";
            }
            else {
                print "No comment.\n";
            }
            print "$message\n";
        }
        push @diagnostics, {
            message => $message,
            type => $type,
            comment => $comment,
        };
    }
    if (! wantarray) {
        die;
    }
    return @diagnostics;
}

1;
