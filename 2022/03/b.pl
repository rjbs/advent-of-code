#!/usr/bin/perl
use v5.36.0;
use experimental 'for_list';
use List::Util qw(uniq);
my $total = 0;
my @lines = <<>>;
chomp @lines;

for my ($snap, $crackle, $pop) (@lines) {
  my %has = map {; $_ => 1 } split //, $snap;
  $has{$_}++ for uniq split //, $crackle;
  $has{$_}++ for uniq split //, $pop;

  my ($key) = grep {; $has{$_} == 3 } keys %has;

  say $key;

  my $priority = $key =~ /[A-Z]/ ? (ord($key) + 27 - ord 'A')
                                 : (ord($key) +  1 - ord 'a');

  $total += $priority;
}

say $total;
