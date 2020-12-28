use rjbs;

use List::AllUtils qw(min);

my $grand = 0;

while (<>) {
  chomp;
  my ($l, $w, $h) = split /x/, $_, 3;

  my @sides = ($l*$w, $w*$h, $h*$l);
  my $area = 2*$sides[0] + 2*$sides[1] + 2*$sides[2];
  my $xtra = min(@sides);

  my $total = $area + $xtra;
  $grand += $total;

  say "$_ -> $total";
}


say "Grand total: $grand";
