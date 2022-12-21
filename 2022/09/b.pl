#!/usr/bin/perl
use v5.36.0;

my @rope = [ 0, 0 ];
push @rope, [ 0, 0, $rope[-1] ] for (1..9);

my @instr = <<>>;
chomp @instr;

my %add = (
  U => [  0,  1 ],
  R => [  1,  0 ],
  D => [  0, -1 ],
  L => [ -1,  0 ],
);

sub adjust_rope {
  for my $knot (@rope) {
    next unless $knot->[2];
    adjust_tail($knot);
  }
}

sub adjust_tail ($tail) {
  my $head = $tail->[2];

  return 0 if abs($head->[0] - $tail->[0]) < 2
           && abs($head->[1] - $tail->[1]) < 2;

  if ($head->[0] == $tail->[0]) {
    $tail->[1] += $head->[1] > $tail->[1] ? 1 : -1;
    return 1;
  }

  if ($head->[1] == $tail->[1]) {
    $tail->[0] += $head->[0] > $tail->[0] ? 1 : -1;
    return 1;
  }

  $tail->[0] += $head->[0] > $tail->[0] ? 1 : -1;
  $tail->[1] += $head->[1] > $tail->[1] ? 1 : -1;

  return 1;
}

my %tail_been;

for my $i (0 .. $#instr) {
  my $instr = $instr[$i];

  my ($dir, $dist) = split /\s+/, $instr;
  my $to_add = $add{ $dir };

  for my $j (1 .. $dist) {
    $rope[0][0] += $to_add->[0];
    $rope[0][1] += $to_add->[1];

    adjust_rope();
    # say "$i, $j, $tail->[0],$tail->[1] ($moved)";
    $tail_been{ join q{,}, $rope[-1]->@* } = 1;
  }
}

say scalar keys %tail_been;
