#!perl
use rjbs;

my $CALLS;
sub xyzzy ($goal, $head, $options) {
  $CALLS++;
  return unless my @nexts = grep { $_ <= $goal } @$options;

  my @rv;
  while (my $next = shift @nexts) {
    # say "(@$head) seeking $goal via $next -> (@nexts)";

    push @rv, $goal == $next ? [ @$head, $next ]
                             : xyzzy($goal - $next, [ @$head, $next ], \@nexts);
  }

  return @rv;
}

my $goal = shift;

my @sizes = <>;
chomp @sizes;

my @opts = xyzzy($goal, [], \@sizes);

my %lengths;
for my $opt (@opts) {
  $lengths{ 0 + @$opt }++;
}

my ($min) = sort { $a <=> $b } keys %lengths;

say 0 + @opts;
say "min: $min, at that len, $lengths{$min}";

say $CALLS;
