use rjbs;

use constant { X => 0, Y => 1 };
my @pos = (0, 0);
my %seen;
$seen{$pos[0],$pos[1]}++;

while (<>) {
  chomp;
  for (split //) {
       if ($_ eq '>') { $pos[X]++ }
    elsif ($_ eq '<') { $pos[X]-- }
    elsif ($_ eq '^') { $pos[Y]++ }
    elsif ($_ eq 'v') { $pos[Y]-- }
    else { next }

    $seen{$pos[0],$pos[1]}++;
  }
}

say scalar keys %seen;
