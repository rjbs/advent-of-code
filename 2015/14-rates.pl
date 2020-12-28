#!perl
use rjbs;

my $race_length = shift @ARGV;
my @reindeer;

while (<>) {
  chomp;
  m{(?<name>\S+) can fly (?<speed>[0-9]+) km/s for (?<duration>[0-9]+) seconds, but then must rest for (?<rest>[0-9]+) seconds.};
  push @reindeer, { %+ };
}

my %score;

for my $round (1 .. $race_length) {
  my %round_score;

  for \my %reindeer (@reindeer) {
    $reindeer{leg} = $reindeer{duration} + $reindeer{rest};

    my $legs = int( $round / $reindeer{leg} );
    my $dist = $legs * $reindeer{speed} * $reindeer{duration};

    my $remainder = $round % $reindeer{leg};
    $remainder = $reindeer{duration} if $remainder >= $reindeer{duration};

    $dist += $remainder * $reindeer{speed};

    $round_score{ $reindeer{name} } = $dist;
  }

  my ($best)  = sort { $b <=> $a } values %round_score;
  my @winners = grep {; $round_score{$_} == $best } keys %round_score;

  $score{$_}++ for @winners;
}

say "$score{$_} $_" for keys %score;
