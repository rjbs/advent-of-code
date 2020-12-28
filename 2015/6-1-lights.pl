use rjbs;

my @lights = map { [ (0) x 1000 ] } (0 ... 999);

my $PAIR = qr/([0-9]+),([0-9]+)/;

while (<>) {
  chomp;
  if (/^turn on $PAIR through $PAIR$/) {
    for my $i ($2-1 .. $4-1) {
      for my $j ($1-1 .. $3-1) {
        $lights[$i][$j] += 1;
      }
    }
  } elsif (/^turn off $PAIR through $PAIR$/) {
    for my $i ($2-1 .. $4-1) {
      for my $j ($1-1 .. $3-1) {
        $lights[$i][$j] -= 1;
        $lights[$i][$j] = 0 if $lights[$i][$j] < 0;
      }
    }
  } elsif (/^toggle $PAIR through $PAIR$/) {
    for my $i ($2-1 .. $4-1) {
      for my $j ($1-1 .. $3-1) {
        $lights[$i][$j] += 2;
      }
    }
  }
}

my $on;
for my $row (@lights) {
  $on += $_ for @$row;
}

say "total on: $on";

