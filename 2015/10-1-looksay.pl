#!perl
use rjbs;

# 1 becomes 11 (1 copy of digit 1).
# 11 becomes 21 (2 copies of digit 1).
# 21 becomes 1211 (one 2 followed by one 1).
# 1211 becomes 111221 (one 1, one 2, and two 1s).
# 111221 becomes 312211 (three 1s, two 2s, and one 1).

my $seed = $ARGV[0];
my $iter = $ARGV[1];

for (1 .. $iter) {
  my @chars = split //, $seed;
  my @result = [ 1, (shift @chars) ];
  for (@chars) {
    if   ($result[-1][1] eq $_) { $result[-1][0]++ }
    else { push @result, [ 1, $_ ] }
  }

  my $next = join q{}, map {; "$_->[0]$_->[1]" } @result;
  # say "$seed -> $next";
  say "$_ -> (" . length($next) . ")";
  $seed = $next;
}
