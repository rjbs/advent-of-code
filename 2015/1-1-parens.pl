use 5.20.0;
my $str = $ARGV[0];
unless ($str) {
  $str = do { local $/; <STDIN> };
}

my $up   = $str =~ tr/(//;
my $down = $str =~ tr/)//;

my $total = $up - $down;

say $total;
