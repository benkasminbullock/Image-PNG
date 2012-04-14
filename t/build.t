# Test that the build process has worked correctly.

use warnings;
use strict;
use FindBin;
use Test::More tests => 1;
eval {
    require JSON::Parse;
};
SKIP: {
    skip "Don't have JSON::Parse", 1 if ($@);
    require JSON::Parse;
    my $file = "$FindBin::Bin/../META.json";
    open my $in, "<", $file or die $!;
    my $json = '';
    while (<$in>) {
        $json .= $_;
    }
    close $in or die $!;
    ok (JSON::Parse::valid_json ($json), "valid json in $file");
};
