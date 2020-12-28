#!perl
use rjbs;

my $side;
my @grid;
my @corners;

my @offsets = map { my $x = $_; map { [ $x, $_ ] } (-1, 0, 1) } (-1, 0, 1);

sub neighbors ($x, $y) {
  my @neighbors = grep { $_->[0] >= 0 && $_->[0] < $side
                      && $_->[1] >= 0 && $_->[1] < $side
                      && ($_->[0] != $x || $_->[1] != $y) }
                  map { [ $x + $_->[0], $y + $_->[1] ] } @offsets;
  return @neighbors;
}

sub step {
  my @newgrid;
  for my $y (0 .. $side - 1) {
    for my $x (0 .. $side - 1) {
      my $pos = $side * $y + $x;
      my @ngh = neighbors($x, $y);
      my @non = grep { my $pos = $side * $_->[1] + $_->[0]; $grid[$pos] } @ngh;

      # my $ns = join q{ }, map {; "($_->[0], $_->[1])" } @ngh;
      # my $nn = join q{ }, map {; "($_->[0], $_->[1])" } @non;
      # say "$pos ($x, $y: $grid[$pos]) -> $ns -> $nn";

      if ($ENV{STUCK} && grep { $_ == $pos } @corners) {
        $newgrid[$pos] = 1;
        next;
      }

      if ($grid[$pos]) { $newgrid[$pos] = @non == 2 || @non == 3; }
      else             { $newgrid[$pos] = @non == 3 }
    }
  }

  @grid = @newgrid;
}

sub print_grid {
  for my $y (0 .. $side - 1) {
    for my $x (0 .. $side - 1) {
      my $pos = $side * $y + $x;
      print $grid[$pos] ? '#' : '.';
    }
    print "\n";
  }
}

sub read_grid {
  my $filename = shift;
  my @lines = `cat $filename`;
  chomp @lines;
  $side = length $lines[0];
  @grid = map { $_ eq '#' ? 1 : 0 } map { split // } @lines;
}

if ($ARGV[0]) {
  read_grid($ARGV[0]);
} else {
  $side = 5;
  @grid = map { scalar(rand > 0.5) } (1 .. ($side * $side));
}

@corners = (0, $#grid, $side-1, ($side-1) * $side);

if ($ENV{STUCK}) {
  @grid[@corners] = (1) x @corners;
}

while (0) {
  print `clear`;
  print_grid;
  scalar <STDIN>;
  step();
}

step() for (1 .. 100);
say 0 + grep { $grid[$_] } (0 .. $#grid);
