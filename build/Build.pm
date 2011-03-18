# This module is for building the Perl distribution from the
# templates. This module is not one of the installed files of the
# distribution.

package Build;
use warnings;
use strict;
use autodie;
use Carp;

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
    $config{base_underscore} = $config{base};
    $config{base_underscore} =~ s/:/_/g;
    $config{out_dir} =~ s/::/\//g;
#    print "Output directory is $config{out_dir}.\n";
    $config{submodule_dir} = "$base/lib/$config{out_dir}";
    $config{main_module_out} = "$base/lib/$config{out_dir}.pm";
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
        if (/^\w+.*?perl_png_(\w+)\s*\(/) {
            push @functions, $1;
        }
    }
    close $input;
#    print "@functions";
    return \@functions;
}

1;
