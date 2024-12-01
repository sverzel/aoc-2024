#!/usr/bin/perl -w

use strict;
use List::Util qw(sum);

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;

my (@l, @r);
while (<$fh>) {
    my ($l, $r) = /(\d+)\s+(\d+)/;
    push @l, $l;
    push @r, $r;
}

@l = sort @l;
@r = sort @r;

my $d = sum(map {abs($l[$_] - $r[$_])} 0 .. @l-1);

print "Total distance: $d\n";
