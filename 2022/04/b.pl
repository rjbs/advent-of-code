#!perl
use v5.36.0;

my sub expand ($str) {
  my ($x, $y) = split /-/, $str;

  my @out;

  for (; $x <= $y; $x++) {
    push @out, $x;
  }

  return @out;
}

my $total;

while (<<>>) {
  chomp;
  my ($left, $rite) = split /,/;

  my %L_final = map {; $_ => 1 } expand($left);
  my %R_final = map {; $_ => 1 } expand($rite);

  $total++ if grep {; $L_final{$_} } keys %R_final;
}

say $total;
