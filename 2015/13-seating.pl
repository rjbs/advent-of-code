#!perl
use rjbs;

# Alice would gain 54 happiness units by sitting next to Bob.
# Alice would lose 79 happiness units by sitting next to Carol.
# Alice would lose 2 happiness units by sitting next to David.
# Bob would gain 83 happiness units by sitting next to Alice.
# Bob would lose 7 happiness units by sitting next to Carol.
# Bob would lose 63 happiness units by sitting next to David.
# Carol would lose 62 happiness units by sitting next to Alice.
# Carol would gain 60 happiness units by sitting next to Bob.
# Carol would gain 55 happiness units by sitting next to David.
# David would gain 46 happiness units by sitting next to Alice.
# David would lose 7 happiness units by sitting next to Bob.
# David would gain 41 happiness units by sitting next to Carol.

my %gain;
while (<>) {
  chomp;
  my ($lhs, $verb, $amt, $rhs) = /\A(\S+) would (\S+) ([0-9]+) .+ (\S+)\.\z/;
  $amt = $verb eq 'gain' ? $amt : -$amt;

  $gain{$lhs}{$rhs}   = $amt;
}

for my $dude (keys %gain) {
  $gain{$dude}{rjbs} = 0;
  $gain{rjbs}{$dude} = 0;
}

sub plugh ($candidates) {
  return unless @$candidates;

  my @options;
  for (0 .. $#$candidates) {
    my @rest = @$candidates;
    my $pick = splice @rest, $_, 1;
    push @options, { start => $pick, choices => \@rest };
  }

  return @options;
}

sub routes {
  my ($candidates, $path) = @_;
  return $path unless @$candidates;
  return unless my @opts = plugh($candidates); # if empty, no way forward

  my $from = $path->[-1];
  my @routes;

  for \my %opt (@opts) {
    push @routes, routes($opt{choices}, [ @$path, $opt{start} ]);
  }

  return @routes;
}

sub print_route ($sroute) {
  say join(q{ -> }, $sroute->{route}->@*),
      " ($sroute->{score})";
}

sub score_for ($route) {
  my $score = 0;
  for my $i (0 .. ($#$route-1)) {
    $score += $gain{ $route->[$i]   }{ $route->[$i+1] };
    $score += $gain{ $route->[$i+1] }{ $route->[$i]   };
  }

  $score += $gain{ $route->[ 0] }{ $route->[-1] };
  $score += $gain{ $route->[-1] }{ $route->[ 0] };

  return $score;
}

print_route($_)
  for sort {; $b->{score} <=> $a->{score} }
      map  {; { score => score_for($_), route => $_ } }
      map  {; routes($_->{choices}, [ $_->{start} ]) }
      plugh([ keys %gain ]);

