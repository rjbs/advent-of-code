use 5.20.0;
my $str = $ARGV[0];
unless ($str) {
  $str = do { local $/; <STDIN> };
}

my $pos = 0;
for my $i (1 .. length $str) {
  my $c = substr $str, $i-1, 1;

  $pos++ if $c eq '(';
  $pos-- if $c eq ')';

  say "basement at $i!" if $pos == -1;
}

say $pos;
