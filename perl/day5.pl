#!/usr/bin/perl -w

use strict;
use Array::Utils qw(:all);

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;

my @rules;
my $sum = 0;
while (<$fh>) {
    if (/\|/) {
        push @rules, [map {chomp; $_} split '\|'];
    }
    elsif (/,/) {
        my @list = map {chomp; $_} split ',';
        my $overlap = 0;
        for (my $i=0; $i < @list; $i++) {
            my @r = map $_->[0], grep {$_->[1] eq $list[$i]} @rules;
            my @p = @list[$i+1..$#list];
            $overlap += intersect(@r, @p);

            if (intersect(@r, @p)) {
                print "Row $. .. $list[$i] intersection: (", join(', ', intersect(@r, @p)), ")\n";
            }
        }

        $sum += $list[$#list / 2] if $overlap == 0;
    }
}

print "Sum: $sum\n";
