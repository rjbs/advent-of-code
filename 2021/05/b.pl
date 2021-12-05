use v5.34.0;
use warnings;

use List::Util qw(min max);

my @lines = <<>>;
chomp @lines;

my %count;

for my $line (@lines) {
  my ($start, $finish) = split / -> /, $line;
  my ($x1, $y1) = split /,/, $start;
  my ($x2, $y2) = split /,/, $finish;

  my $dx = $x1 == $x2 ? 0 : $x2 > $x1 ? 1 : -1;
  my $dy = $y1 == $y2 ? 0 : $y2 > $y1 ? 1 : -1;

  my $x = $x1;
  my $y = $y1;

  while (1) {
    say "$line - $x,$y";
    $count{"$x,$y"}++;
    last if $x == $x2 && $y == $y2;
    $x += $dx;
    $y += $dy;
  }
}

my (@two) = grep {; $count{$_} > 1 } keys %count;
say 0+@two;
