#!perl
use rjbs;

my @pairs;
my $start;
my @queue;
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

  @queue = [ 0, $_ ];
  $done = 1;
}

@$_ = (reverse @$_) for @pairs;

my %seen;

my $i;
while (my $try = shift @queue) {
  my $depth = $try->[0] + 1;
  my $str   = $try->[1];

  my @local_queue;

  for my $pair (@pairs) {
    my ($lhs, $rhs) = @$pair;

    my @hunks = split /($lhs)/, $str;
    my @hits  = grep {; $hunks[$_] eq $lhs } keys @hunks;

    for my $i (@hits) {
      my $new = join q{}, map { $_ == $i ? $rhs : $hunks[$_] } keys @hunks;
      next if $seen{ $new }++;
      if ($new eq 'e') { say "finished at depth $i"; exit(0) }
      push @queue, [ $depth, $new ];
      @queue = sort {
                #$a->[0] <=> $b->[0]
                #||
                length $a->[1] <=> length $b->[1] }
               @queue;
      @queue = grep { length $queue[0][1] == length $_->[1] } @queue;
      # die "\n\n$target\n$lhs\n@hunks\n$new";
      printf "%i / %i - %s\n", $depth, length $new, $new;
    }
  }
}

say 0+(keys %seen);
