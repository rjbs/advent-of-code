#!/usr/bin/perl
use v5.38.0;

my $x = 0;

for (<ARGV>) {
  my ($first) = /^\D*(\d)/;
  my ($final) = /(\d)\D*$/;

  $x += "$first$final";
}

say $x;
