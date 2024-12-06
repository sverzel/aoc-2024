#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;
my $data = [map {chomp; [split //, $_]} <$fh>];


my ($x, $y, $d) = (0, 0, 0);
OUTER: for ($y=0; $y < @$data; $y++) {
    for ($x=0; $x < @{$data->[$y]}; $x++) {
        last OUTER if $data->[$y][$x] eq '^';
    }
}

while ($x > -1 && $x < @{$data->[0]} && $y > -1 && $y < @$data) {
    $data->[$y][$x] = 'X';

    my $next =  $d == 0 ? [0,-1] :
                $d == 1 ? [1, 0] :
                $d == 2 ? [0, 1] :
                $d == 3 ? [-1,0] : [];

    if ($data->[$y + $next->[1]][$x + $next->[0]] ne '#') {
        ($x, $y) = ($x + $next->[0], $y + $next->[1]);
    }
    else {
        $d = ($d + 1) % 4;
    }
}

my $p = 0;
for (my $y=0; $y < @$data; $y++) {
    for (my $x=0; $x < @{$data->[$y]}; $x++) {
        $p++ if $data->[$y][$x] eq 'X';
    }
}

print "Number of visited spots: $p\n";
