#!perl
use rjbs;
use List::Util qw(sum);

my %ingredient;
while (<>) {
  chomp;
  my ($what, $rest) = split /: /, $_, 2;
  for my $thing (split /,\s*/, $rest) {
    my ($prop, $val) = split /\s+/, $thing;
    $ingredient{$what}{$prop} = $val;
  }
}

sub permutations ($target, @ingredients) {
  return () if $target == 0;
  return {$ingredients[0] => $target} if @ingredients == 1;

  my @results;
  for my $ingredient (@ingredients) {
    for my $i (1 .. $target) {
      push @results, { $ingredient => $i, %$_ }
        for permutations($target - $i, grep { $_ ne $ingredient } @ingredients);
    }
  }

  return @results;
}

sub score (%recipe) {
  my $score = 1;
  for my $prop (qw(capacity durability flavor texture)) {
    my $value = sum map { $ingredient{$_}{$prop} * $recipe{$_} } keys %recipe;
    $value = 0 if $value < 0;
    $score *= $value;
  }

  return $score;
}

sub calorie_count (%recipe) {
  my $count = sum map { $ingredient{$_}{calories} * $recipe{$_} } keys %recipe;
}

my $best;

for my $recipe (permutations(100, keys %ingredient)) {
  next unless calorie_count(%$recipe) == 500;

  my $score = score(%$recipe);
  $best = { score => $score, recipe => $recipe }
    if !$best or $best->{score} < $score;
}

use Data::Dumper;
warn Dumper($best);
