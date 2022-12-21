#!perl
use v5.36.0;

my sub expand ($str) {
  my ($x, $y) = split /-/, $str;

  my $out = q{};

  for (; $x <= $y; $x++) {
    $out .= qq{<$x>};
  }

  return $out;
}

my $total;

while (<<>>) {
  chomp;
  my ($left, $rite) = split /,/;

  my $L_final = expand($left);
  my $R_final = expand($rite);

  $total++
    if ($L_final eq $R_final)
    || (index($L_final, $R_final) >= 0)
    || (index($R_final, $L_final) >= 0);
}

say $total;
