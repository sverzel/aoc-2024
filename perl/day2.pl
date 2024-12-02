#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;

my $s = 0;
my $ss = 0;
while (<$fh>) {
    my @c = split /\s+/;
    for my $i ( -1 .. $#c ) {
        my @r = @c;
        splice @r, $i, 1 if $i > -1;
        my @a = sort {$a<=>$b} @r;
        my @d = sort {$b<=>$a} @r;

        if ((grep {$_ > 0 && $_ < 4} map { abs($r[$_] - $r[$_+1])  } 0 .. $#r-1) == @r-1 &&
            ( (grep { $a[$_] == $r[$_] } 0 .. $#r) == @r || (grep { $d[$_] == $r[$_] } 0 .. $#r) == @r )) {
            $s++ if $i == -1;
            $ss++;

            last;
        }
    }
}

print "$s are safe\n";
print "$ss are safe-ish\n";
