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

  if ($x1 == $x2) {
    say "$x1,$_" for min($y1, $y2) .. max($y1, $y2);
    $count{"$x1,$_"}++ for min($y1, $y2) .. max($y1, $y2);
  } elsif ($y1 == $y2) {
    say "$_,$y1" for min($x1, $x2) .. max($x1, $x2);
    $count{"$_,$y1"}++ for min($x1, $x2) .. max($x1, $x2);
  }
}

my (@two) = grep {; $count{$_} > 1 } keys %count;
say 0+@two;
