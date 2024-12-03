#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';
local $/;
open my $fh, $input or die $!;
my $data = <$fh>;

sub add_mul {
    my $data = shift;
    my @m = $data =~ /mul\(\d+,\d+\)/g;
    my $s = 0;
    foreach (@m) {
        my ($l, $r) = /\((\d+),(\d+)\)/;
        $s += $l*$r;
    }

    return $s;
}

print "Sum of multiplications: ", add_mul($data), "\n";

my @s = grep defined, split /(do\(\))|(don\'t\(\))/, $data;

$data = '';
my $capt = 1;
foreach my $s(@s) {
    $capt = $s eq q[don't()] ? 0 : $s eq q[do()] ? 1 : $capt;
    $data .= "$s" if $capt;
}

print "Sum of enabled multiplications: ", add_mul($data), "\n";
