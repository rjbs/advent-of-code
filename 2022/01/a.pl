use v5.36.0;

my @burden = 0;

while (<<>>) {
  chomp;
  if (length) { $burden[-1] += $_; next }
  else { push @burden, 0 }
}

my @sorted = sort {; $b <=> $a } @burden;
say for @sorted;

