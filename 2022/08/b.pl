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

my $max_score = 0;

for my $y (0 .. $max) {
  TREE: for my $x (0 .. $max) {
    my $h = substr $lines[$y], $x, 1;

    next if $h == 0;

    my $above   = join q{}, reverse $col[$x]->@[ 0        .. ($y - 1) ];
    my $below   = join q{},         $col[$x]->@[ ($y + 1) .. $max     ];
    my $right   = join q{},         $row[$y]->@[ ($x + 1) .. $max     ];
    my $left    = join q{}, reverse $row[$y]->@[ 0        .. ($x - 1) ];

    my $less = $h - 1;
    my $pat = qr{\A([0-$less]*(?:[$h-9]|$))};

    my ($a_s) = $above =~ $pat;
    my ($b_s) = $below =~ $pat;
    my ($r_s) = $right =~ $pat;
    my ($l_s) = $left  =~ $pat;

    my $a_d = length($a_s) // 0;
    my $b_d = length($b_s) // 0;
    my $r_d = length($r_s) // 0;
    my $l_d = length($l_s) // 0;

    my $score = $a_d * $b_d * $r_d * $l_d;

    $max_score = $score if $score > $max_score;
    say "$x,$y = $h / $above:$a_d $below:$b_d $right:$r_d $left:$l_d == $score";
  }
}

say "MAX: $max_score";
