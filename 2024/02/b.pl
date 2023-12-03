#!/usr/bin/perl
use v5.38.0;

my $total = 0;
GAME: while (<ARGV>) {
  my ($prefix, $rest) = split /: /;
  my ($n) = $prefix =~ /Game (\d+)/;
  my @draws = map { split /, / } split /; /, $rest;

  my %max;

  for my $draw (@draws) {
    my ($x, $color) = split /\s/, $draw;
    $max{$color} = $x unless ($max{$color}//0) > $x;
  }

  my $power = 1;
  $power *= $_ for values %max;
  $total += $power;
}

say $total;
