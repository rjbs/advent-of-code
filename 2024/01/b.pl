#!/usr/bin/perl
use v5.38.0;

my $x = 0;

my @words = qw(zero one two three four five six seven eight nine);

my %value = (
  (map {; $_, $_ } (0 .. 9)),
  (map {; $words[$_], $_ } keys @words),
);

my $pat = join q{|}, keys %value;

for (<ARGV>) {
  my ($first) = /^.*?($pat)/;
  my ($final) = /^.*($pat)/;
  $x += "$value{$first}$value{$final}";
}

say $x;
