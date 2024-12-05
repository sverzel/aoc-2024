#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;

my %rules;
my $sum = 0;
my $sum_corrected = 0;
while (<$fh>) {
    if (/\|/) {
        my ($l, $r) = /(\d+)\|(\d+)/;
        $rules{$l}{$r} = 1;
    }
    elsif (/,/) {
        my @list = /(\d+)/g;
        my @sorted_list = sort { $rules{$a}{$b} ? -1 : 1 } @list;

        if ((grep { $list[$_] == $sorted_list[$_] } 0 .. $#list) == @list) {
            $sum += $list[$#list / 2];
        }
        else {
            $sum_corrected += $sorted_list[$#sorted_list / 2];
        }
    }
}

print "Sum: $sum\n";
print "Sum corrected: $sum_corrected\n";
