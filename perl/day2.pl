#!/usr/bin/perl -w

use strict;
use List::Util qw(sum);

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;

my $s = 0;
my $ss = 0;
while (<$fh>) {
    my @r = split /\s+/;
    my @a = sort {$a<=>$b} @r;
    my @d = sort {$b<=>$a} @r;
    if ((grep {$_ > 0 && $_ < 4} map { abs($r[$_] - $r[$_+1])  } 0 .. $#r-1) == @r-1 &&
        ( (grep { $a[$_] == $r[$_] } 0 .. $#r) == @r || (grep { $d[$_] == $r[$_] } 0 .. $#r) == @r )) {
        $s++;
    }
    else {
        for my $i ( 0 .. $#r ) {
            my @c = @r;
            splice @c, $i, 1;
            my @a = sort {$a<=>$b} @c;
            my @d = sort {$b<=>$a} @c;
            if ((grep {$_ > 0 && $_ < 4} map { abs($c[$_] - $c[$_+1])  } 0 .. $#c-1) == @c-1 &&
                ( (grep { $a[$_] == $c[$_] } 0 .. $#c) == @c || (grep { $d[$_] == $c[$_] } 0 .. $#c) == @c )) {
                $ss++;
                last;
            }
        }
    }
}

print "$s are safe\n";
$ss += $s;
print "$ss are safe-ish\n";
