use rjbs;
use List::Util qw(sum);

my %dist;
while (<>) {
  my ($from, $to, $dist) = /^(\S+) to (\S+) = ([0-9]+)$/;

  $dist{$from}{$to} = $dist;
  $dist{$to}{$from} = $dist;
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

  my $from = $path->[-1][0];
  my @routes;

  for \my %opt (@opts) {
    next unless defined (my $dist = $dist{ $from }{ $opt{start} });
    push @routes, routes($opt{choices}, [ @$path, [ $opt{start}, $dist ] ]);
  }

  return @routes;
}

sub print_route ($wroute) {
  say join(q{ -> }, map {; $_->[0] } $wroute->{route}->@*),
      " ($wroute->{total})";
}

print_route($_)
  for sort {; $b->{total} <=> $a->{total} }
      map  {; { total => (sum map {; $_->[1] } @$_), route => $_ } }
      map  {; routes($_->{choices}, [ [$_->{start}, 0] ]) }
      plugh([ keys %dist ]);
