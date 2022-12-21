#!perl
use v5.36.0;

my %score = qw(rock 1 paper 2 scissors 3);
my %get   = qw(X 0 Y 3 Z 6);

my %play  = qw( A rock B paper C scissors );
my %to_get = qw(
  rockX scissors
  rockY rock
  rockZ paper
  paperX rock
  paperY paper
  paperZ scissors
  scissorsX paper
  scissorsY scissors
  scissorsZ rock
);

my $total = 0;

while (<<>>) {
  chomp;
  my ($ls, $rs) = split /\s+/;

  my $lp = $play{$ls};
  my $rp = $to_get{"$lp$rs"};

  warn "$ls ($lp) $rs -> $rp";
  $total += $get{$rs} + $score{$rp};
}

say $total;
