#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;
my $data = [map {chomp; [split //, $_]} <$fh>];


my ($x, $y, $d) = (0, 0, '');
OUTER: for ($y=0; $y < @$data; $y++) {
    for ($x=0; $x < @{$data->[$y]}; $x++) {
        last OUTER if ($d) = $data->[$y][$x] =~ /([<>^v])/;
    }
}

while ($d eq '' || ($x > -1 && $x < @{$data->[0]} && $y > -1 && $y < @$data)) {
    $data->[$y][$x] = 'X';

    if ($d eq '^') {
        if ($data->[$y-1][$x] ne '#') {
            $y--;
        }
        else {
            $d = '>';
        }
    }
    elsif ($d eq '>') {
        if ($data->[$y][$x+1] ne '#') {
            $x++;
        }
        else {
            $d = 'v';
        }
    }
    elsif ($d eq 'v') {
        if ($data->[$y+1][$x] ne '#') {
            $y++;
        }
        else {
            $d = '<';
        }
    }
    elsif ($d eq '<') {
        if ($data->[$y][$x-1] ne '#') {
            $x--;
        }
        else {
            $d = '^';
        }
    }
}

my $p = 0;
for (my $y=0; $y < @$data; $y++) {
    for (my $x=0; $x < @{$data->[$y]}; $x++) {
        $p++ if $data->[$y][$x] eq 'X';
    }
}

print "Number of visited spots: $p\n";
