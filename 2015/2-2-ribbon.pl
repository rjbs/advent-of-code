use rjbs;

use List::AllUtils qw(min);

my $grand_paper  = 0;
my $grand_ribbon = 0;

while (<>) {
  chomp;
  my ($l, $w, $h) = sort { $a <=> $b } split /x/, $_, 3;

  my $ribbon = 2*$l + 2*$w;

  my @sides  = sort { $a <=> $b } ($l*$w, $w*$h, $h*$l);
  my $area   = 2*$sides[0] + 2*$sides[1] + 2*$sides[2];

  $ribbon += $l * $w * $h; # bow

  my $total = $area + $sides[0];

  $grand_paper  += $total;
  $grand_ribbon += $ribbon;

  say "$_ -> $total ft^2 paper, $ribbon ft ribbon";
}


say "Grand total: $grand_paper paper, $grand_ribbon ribbon";
