use warnings;
use strict;
use Test::More tests => 22;
use FindBin;
use File::Compare;
BEGIN { use_ok('File::PNG::Libpng') };
use File::PNG::Libpng;
use utf8;

my $builder = Test::More->builder;

binmode $builder->output,         ":utf8";
binmode $builder->failure_output, ":utf8";
binmode $builder->todo_output,    ":utf8";
binmode STDOUT, ":utf8";

my $png = File::PNG::Libpng::create_read_struct ();

ok ($png, 'call "create_read_struct" and get something');

my $info = File::PNG::Libpng::create_info_struct ($png);

ok ($info, 'call "create_info_struct" and get something');

my $file_name = "$FindBin::Bin/test.png";

open my $file, "<", $file_name or die "Can't open '$file_name': $!";

File::PNG::Libpng::init_io ($png, $file);
File::PNG::Libpng::read_info ($png, $info);

my %IHDR;

my $status = File::PNG::Libpng::get_IHDR ($png, $info, \%IHDR);
ok ($status == 1, "successfully called get_IHDR");
ok ($IHDR{width} == 100, "width");
ok ($IHDR{height} == 100, "height");
File::PNG::Libpng::destroy_read_struct ($png, $info);
close $file or die $!;

my $file_in_name = "$FindBin::Bin/test.png";
open my $file_in, "<", $file_in_name or die "Can't open '$file_in_name': $!";

my $png_in = File::PNG::Libpng::create_read_struct ();
my $info_in_out = File::PNG::Libpng::create_info_struct ($png_in);
File::PNG::Libpng::init_io ($png_in, $file_in);
File::PNG::Libpng::read_png ($png_in, $info_in_out, 0);
close $file_in or die $!;
my $file_out_name = "$FindBin::Bin/test-write.png";
my $png_out = File::PNG::Libpng::create_write_struct ();
open my $file_out, ">", $file_out_name or die "Can't open '$file_out_name': $!";
File::PNG::Libpng::init_io ($png_out, $file_out);
File::PNG::Libpng::write_png ($png_out, $info_in_out, 0);
close $file_out or die $!;
ok (compare ($file_in_name, $file_out_name) == 0, "copy file");

my $time_file_name = "$FindBin::Bin/with-time.png";
open my $file2, "<", $time_file_name or die "Can't open '$time_file_name': $!";
my $png2 = File::PNG::Libpng::create_read_struct ();
my $info2 = File::PNG::Libpng::create_info_struct ($png2);
File::PNG::Libpng::init_io ($png2, $file2);
File::PNG::Libpng::read_info ($png2, $info2);
my %times;
File::PNG::Libpng::get_tIME ($png2, $info2, \%times);
ok ($times{year} == 2010, "year");
ok ($times{month} == 12, "month");
ok ($times{day} == 29, "day");
ok ($times{hour} == 16, "hour");
ok ($times{minute} == 20, "minute");
ok ($times{second} == 20, "second");
File::PNG::Libpng::destroy_read_struct ($png2, $info2);
close $file2 or die $!;

my $text_file_name = "$FindBin::Bin/with-text.png";
open my $file3, "<", $text_file_name or die "Can't open '$text_file_name': $!";
my $png3 = File::PNG::Libpng::create_read_struct ();
my $info3 = File::PNG::Libpng::create_info_struct ($png3);
File::PNG::Libpng::init_io ($png3, $file3);
File::PNG::Libpng::read_info ($png3, $info3);
my @text_chunks;
File::PNG::Libpng::get_text ($png3, $info3, \@text_chunks);

my $chunk1 = $text_chunks[0];
ok ($chunk1->{compression} == 0, "text compression");
ok ($chunk1->{key} eq 'Title', "text key");
ok ($chunk1->{text} eq 'Mona Lisa', "text text");
my $chunk3 = $text_chunks[2];
ok ($chunk3->{compression} == 1, "text compression for iTXT");
ok ($chunk3->{key} eq 'Detective', "text key");
ok ($chunk3->{lang_key} eq '探偵', "text lang_key");
ok ($chunk3->{text} eq '工藤俊作', "text text in UTF-8");
File::PNG::Libpng::destroy_read_struct ($png3, $info3);
close $file3 or die $!;

my $number_version = File::PNG::Libpng::access_version_number ();
#print $number_version;
#print "\n";
ok ($number_version =~ /^\d+$/, "Numerical version number OK");
my $version = File::PNG::Libpng::get_libpng_ver ();
#print $version;
#print "\n";
$version =~ s/\./0/g;
ok ($number_version == $version, "Library version OK");

# for my $text_chunk (@text_chunks) {
# for my $k (keys %$text_chunk) {
#     if (defined $text_chunk->{$k}) {
#         print "$k: $text_chunk->{$k}\n";
#     }
# }
    
# }

# Local variables:
# mode: perl
# End:
