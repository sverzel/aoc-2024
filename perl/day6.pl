#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

open my $fh, $input or die $!;
my $data = [map {chomp; [split //, $_]} <$fh>];

sub test {
    my ($data) = @_;

    my ($x, $y, $d) = (0, 0, 0);
    OUTER: for ($y=0; $y < @$data; $y++) {
        for ($x=0; $x < @{$data->[$y]}; $x++) {
            last OUTER if $data->[$y][$x] eq '^';
        }
    }

    my %visited;
    while ($x > -1 && $x < @{$data->[0]} && $y > -1 && $y < @$data) {
        return if $visited{$x}{$y}{$d};

        $visited{$x}{$y}{$d} = 1;

        my $next =  $d == 0 ? [0,-1] :
                    $d == 1 ? [1, 0] :
                    $d == 2 ? [0, 1] :
                    $d == 3 ? [-1,0] : [];

        last if ($y + $next->[1]) < 0 || ($y + $next->[1]) >= @$data || ($x + $next->[0]) < 0 || ($x + $next->[0]) >= @{$data->[$y]};

        if ($data->[$y + $next->[1]][$x + $next->[0]] ne '#') {
            ($x, $y) = ($x + $next->[0], $y + $next->[1]);
        }
        else {
            $d = ($d + 1) % 4;
        }
    }

    my @l;
    foreach my $x(keys %visited) {
        foreach my $y( keys %{$visited{$x}}) {
            push @l, [$x, $y];
        }
    }

    return @l;
}

my @visited_spots = test($data);

print "Number of visited spots: " . @visited_spots . "\n";

my $c = 0;
for (@visited_spots) {
        my $copy = [map { [@$_]} @$data];
        $copy->[$_->[1]][$_->[0]] = '#';
        $c++ unless defined test($copy);
}

print "Number of looped configurations: $c\n";
