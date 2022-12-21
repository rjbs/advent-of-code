#!/usr/bin/perl
use v5.36.0;

my $total = 0;

while (<<>>) {
  chomp;
  my $len = length;
  my $left  = $_;
  my $right = substr $left, $len / 2, $len, '';

  say $left;
  say $right;

  my %l_has = map {; $_ => 1 } split //, $left;
  my %duped = map {; $l_has{$_} ? ($_ => 1) : () } split //, $right;
  my @duped = keys %duped;

  my $priority = $duped[0] =~ /[A-Z]/ ? (ord($duped[0]) + 27 - ord 'A')
                                      : (ord($duped[0]) +  1 - ord 'a');

  say "[ $left | $right ] duped: @duped -> $priority";

  $total += $priority;
}

say $total;
