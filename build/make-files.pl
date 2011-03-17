#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use Template;
BEGIN {
    use FindBin;
    use lib "$FindBin::Bin";
    use Build;
};
use autodie;

my %config = Build::read_config ();

my $tt = Template->new (
    ABSOLUTE => 1,
    INCLUDE_PATH => $config{tmpl_dir},
    STRICT => 1,
);

my @files = qw/
                  Libpng.pm
                  Libpng.xs
                  typemap
                  perl-libpng.c
                  PNG.pm
                  Makefile.PL
                  PNG.t
                  Libpng.t
                  PLTE.t
                  Const.t
              /;

my %vars;
$vars{config} = \%config;

for my $file (@files) {
    my $template = "$file.tmpl";
    my $output;
    if ($file eq 'Makefile.PL' || $file eq 'Libpng.xs' ||
        $file eq 'typemap' || $file eq 'perl-libpng.c') {
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
    print "Processing $template into $output.\n";
    if (-f $output) {
        chmod 0644, $output;
    }
    $tt->process ($template, \%vars, $output)
        or die '' . $tt->error ();
    chmod 0444, $output;
}

