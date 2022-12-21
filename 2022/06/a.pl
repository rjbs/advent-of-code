#!/usr/bin/perl
use v5.36.0;

my $input = <<>>;
chomp $input;

for (my $i = 0; $i < length($input) - 4; $i++) {
  my $substr = substr $input, $i, 14;
  my %seen = map {; $_ => 1 } split //, $substr;

  next unless %seen == 14;
  say $i + 14;
  last;
}
