use rjbs;

my $ring_size = shift || die "need ring size\n";

my @seen_ring = map { [0,0] } (1 .. $ring_size);

my %seen;
$seen{"0 0"}++;

while (<>) {
  chomp;
  for (split //) {
       if ($_ eq '>') { $seen_ring[0][0]++ }
    elsif ($_ eq '<') { $seen_ring[0][0]-- }
    elsif ($_ eq '^') { $seen_ring[0][1]++ }
    elsif ($_ eq 'v') { $seen_ring[0][1]-- }
    else { next }

    $seen{"$seen_ring[0]->@*"}++;
    push @seen_ring, (shift @seen_ring);
  }
}

say scalar keys %seen;
