#!perl
use rjbs;
use List::MoreUtils qw(uniq);

my $target = $ARGV[0];

my %used;

sub still_working (@f) {
  grep { $used{$_}++ < 50 } @f
}

sub factors ($x) {
  sort { $a <=> $b } uniq map { $_, $x/$_ } grep { $x % $_ == 0 } (1 .. int(sqrt($x)) + 1)
}

my $house = 0;
while (++$house) {
  my @factors = still_working( factors($house) );
  my $score = 0;
  $score += 11 * $_ for @factors;
  say "$house  ->  @factors -> $score";
  last if $score >= $target;
}
