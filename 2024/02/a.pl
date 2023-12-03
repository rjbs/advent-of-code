#!/usr/bin/perl
use v5.38.0;

my %MAX = (red => 12, green => 13, blue => 14);

my $total = 0;
GAME: while (<ARGV>) {
  my ($prefix, $rest) = split /: /;
  my ($n) = $prefix =~ /Game (\d+)/;
  my @draws = map { split /, / } split /; /, $rest;

  my %max;

  for my $draw (@draws) {
    my ($x, $color) = split /\s/, $draw;
    $max{$color} = $x unless ($max{$color}//0) > $x;
    next GAME if $max{$color} > $MAX{$color};
  }

  $total += $n;
}

say $total;
