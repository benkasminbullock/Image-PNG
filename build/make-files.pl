#!/home/ben/software/install/bin/perl

# This turns the template files into their distribution-ready forms.

use warnings;
use strict;
use autodie;
use Template;
use Perl::Build qw/get_info get_commit/;
use FindBin '$Bin';
use lib "$Bin";
use ImagePNGBuild;
use LibpngInfo 'template_vars', '@chunks';

my %config = ImagePNGBuild::read_config ();

my $tt = Template->new (
    ABSOLUTE => 1,
    INCLUDE_PATH => $config{tmpl_dir},
#    STRICT => 1,
);

my @files = qw/
    Container.pm
    Makefile.PL
    PNG.pm
    PNG.pod
    PNG.t
    Util.pm
/;

my %vars;
$vars{config} = \%config;
$vars{self} = $0;
$vars{date} = scalar gmtime ();
my %pbv = (base => "$Bin/..");
$vars{commit} = get_commit (%pbv);

# Get lots of stuff about libpng from the module LibpngInfo in the
# same directory as this script, used to build documentation etc.

template_vars (\%vars);

# These files go in the top directory

my %top_dir = (
    'Makefile.PL' => 1,
);

my @outputs;

for my $file (@files) {
    my $template = "$file.tmpl";
    my $output;
    if ($top_dir{$file}) {
        $output = $file;
    }
    elsif ($file eq 'PNG.pm') {
        $output = $config{main_module_out};
    }
    elsif ($file eq 'PNG.pod') {
        $output = $config{pod_out};
    }
    elsif ($file =~ /.t$/) {
        $output = "t/$file";
    }
    else {
        $output = "$config{submodule_dir}/$file";
    }
    push @outputs, $output;

#    print "$output\n";
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

# These PNGs are used in the tests. Many of them are from
# http://libpng.org/pub/png/pngsuite.html.

my @test_pngs = qw!
    t/test.png
    t/with-text.png
    t/with-time.png
    t/tantei-san.png
    t/bgyn6a16.png
    t/xlfn0g04.png
    t/ccwn2c08.png
    t/cdun2c08.png
    t/saru-fs8.png
!;

# Other files which aren't made from templates.

my @extras = qw!
    tmpl/author
    tmpl/config
    tmpl/examples_doc
    tmpl/generated
    tmpl/libpng_doc
    tmpl/other_modules
    tmpl/png_doc
    tmpl/pngspec
    tmpl/version
    tmpl/warning
    build/ImagePNGBuild.pm
    build/LibpngInfo.pm
    build/make-files.pl
    MANIFEST
    MANIFEST.SKIP
    perl-libpng.h
    README
!;

my @mani;
push @mani, map {"tmpl/$_.tmpl"} @files;
push @mani, @outputs;
push @mani, @test_pngs;
push @mani, @extras;
push @mani, 'makeitfile';

exit;

