#!perl
use v5.36.0;

my %play  = qw( A rock B paper C scissors
                X rock Y paper Z scissors);
my %score = qw(rock 1 paper 2 scissors 3);
my %result = (
  'rock rock'         => 3,
  'rock paper'        => 6,
  'rock scissors'     => 0,
  'paper rock'        => 0,
  'paper paper'       => 3,
  'paper scissors'    => 6,
  'scissors rock'     => 6,
  'scissors paper'    => 0,
  'scissors scissors' => 3,
);

my $total = 0;

while (<<>>) {
  chomp;
  my ($ls, $rs) = split /\s+/;

  my $lp = $play{$ls};
  my $rp = $play{$rs};

  $total += $result{ "$lp $rp" } + $score{$rp};
}

say $total;
