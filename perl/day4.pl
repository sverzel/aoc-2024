#!/usr/bin/perl -w

use strict;
use Time::HiRes;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;
my $data = [map {chomp; [split //, $_]} <$fh>];

my $xmas = 0;
for (my $y=0; $y < @$data; $y++) {
    for (my $x=0; $x < @{$data->[$y]}; $x++) {
        for my $d( [0,-1], [1,-1], [1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1] ) {
            my $s = $data->[$y][$x];
            for my $c( 1 .. 3 ) {
                next if ($y + $d->[1]*$c) < 0 || ($y + $d->[1]*$c) >= @$data || ($x + $d->[0]*$c) < 0 || ($x + $d->[0]*$c) >= @{$data->[$y]};
                $s .= $data->[$y + $d->[1]*$c][$x + $d->[0]*$c];
            }

            $xmas++ if $s eq 'XMAS';
        }
    }
}

print "Number of 'XMAS': $xmas\n";

my $x_mas = 0;
for (my $y=1; $y < @$data-1; $y++) {
    for (my $x=1; $x < @{$data->[$y]}-1; $x++) {
        $x_mas++ if
            ($data->[$y-1][$x-1] . $data->[$y][$x] . $data->[$y+1][$x+1]) =~ /MAS|SAM/ &&
            ($data->[$y+1][$x-1] . $data->[$y][$x] . $data->[$y-1][$x+1]) =~ /MAS|SAM/
    }
}

print "Number of 'X-MAS': $x_mas\n";
