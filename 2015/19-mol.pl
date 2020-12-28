#!perl
use rjbs;

my @pairs;
my $target;
my $done;

while (<>) {
  die "input after target" if $done;
  chomp;
  next unless length;
  if (my ($lhs, $rhs) = m/(\S+) => (\S+)/) {
    push @pairs, [ $lhs, $rhs ];
    say "$lhs --> $rhs";
    next;
  }

  $target = $_;
  $done = 1;
}

my %seen;
for my $pair (@pairs) {
  my ($lhs, $rhs) = @$pair;

  my @hunks = split /($lhs)/, $target;
  my @hits  = grep {; $hunks[$_] eq $lhs } keys @hunks;

  for my $i (@hits) {
    my $new = join q{}, map { $_ == $i ? $rhs : $hunks[$_] } keys @hunks;
    $seen{ $new }++;
    # die "\n\n$target\n$lhs\n@hunks\n$new";
  }
}

say 0+(keys %seen);
