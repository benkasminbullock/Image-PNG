#!/home/ben/software/install/bin/perl

# This turns the template files into their distribution-ready forms.

use warnings;
use strict;
use Template;
BEGIN {
    use FindBin;
    use lib "$FindBin::Bin";
    use Build;
    use LibpngInfo 'template_vars';
};
use autodie;

my %config = Build::read_config ();

my $tt = Template->new (
    ABSOLUTE => 1,
    INCLUDE_PATH => $config{tmpl_dir},
#    STRICT => 1,
);

my @files = qw/
                  Libpng.pm
                  Libpng.xs
                  typemap
                  perl-libpng.c
                  PNG.pm
                  Container.pm
                  Makefile.PL
                  PNG.t
                  Libpng.t
                  PLTE.t
                  Const.t
                  META.json
              /;

my %vars;
$vars{config} = \%config;
$vars{functions} = Build::get_functions (\%config);
$vars{self} = $0;
$vars{date} = scalar gmtime ();

# Get lots of stuff about libpng from the module LibpngInfo in the
# same directory as this script, used to build documentation etc.

template_vars (\%vars);
#for my $x (@{$vars{ihdr_fields}}) {
#    print $x->{name}, "\n";
#}

# These files go in the top directory

my %top_dir = (
    'Makefile.PL' => 1,
    'Libpng.xs' => 1,
    'typemap' => 1,
    'perl-libpng.c' => 1,
    'META.json' => 1,
);

for my $file (@files) {
    my $template = "$file.tmpl";
    my $output;
    if ($top_dir{$file}) {
        $output = $file;
    }
    elsif ($file eq 'PNG.pm') {
        $output = $config{main_module_out};
    }
    elsif ($file =~ /.t$/) {
        $output = "$config{base_dir}/t/$file";
    }
    else {
        $output = "$config{submodule_dir}/$file";
    }
#    print "Processing $template into $output.\n";
    $vars{input} = $template;
    $vars{output} = $output;
    if (-f $output) {
        chmod 0644, $output;
    }
    $tt->process ($template, \%vars, $output)
        or die '' . $tt->error ();
    chmod 0444, $output;
}

