#!/usr/bin/perl
use v5.36.0;

my @lines = <<>>;
chomp @lines;

my $max = length($lines[0]) - 1;

my @row = map {; [ split //, $_ ] } @lines;
my @col = map {;
            my $x = $_;
            [ map {; substr $_, $x, 1 } @lines ]
          } (0 .. $max);

my $visible = 0;

for my $y (0 .. $max) {
  TREE: for my $x (0 .. $max) {
    if ($x == 0 || $y == 0 || $x == $max || $y == $max) {
      $visible++;
      next TREE;
    }

    my @above   = $col[$x]->@[ 0        .. ($y - 1) ];
    my @below   = $col[$x]->@[ ($y + 1) .. $max     ];
    my @right   = $row[$y]->@[ ($x + 1) .. $max     ];
    my @left    = $row[$y]->@[ 0        .. ($x - 1) ];

    my $h = substr $lines[$y], $x, 1;
    if ( (@above == grep {; $_ < $h } @above)
      || (@below == grep {; $_ < $h } @below)
      || (@right == grep {; $_ < $h } @right)
      || (@left  == grep {; $_ < $h } @left)
    ) {
      # warn "$x,$y tree $h - VIZ (@above|@right|@below|@left)";
      $visible++;
      next TREE;
    }

    # warn "$x,$y tree $h - INVIZ (@above|@right|@below|@left)";

    # say "$x,$y - " . substr $lines[$y], $x, 1;
    # say "$x,$y - " . ($row[$y][$x] // '~');
    # say "$x,$y - " . ($col[$x][$y] // '~');
  }
}

say $visible;
