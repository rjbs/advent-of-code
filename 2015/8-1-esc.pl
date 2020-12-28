#!perl
use rjbs;

my $total = 0;
while (<>) {
  chomp;
  my $ev = eval $_;
  my $rq = q{"} . (quotemeta $_) . q{"};
  say "$_ -> " . quotemeta $_;
  $total += length($rq) - length $_;
}
say "total: $total";
