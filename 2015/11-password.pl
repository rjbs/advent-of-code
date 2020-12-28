use rjbs;

my $seed = $ARGV[0];

sub is_okay ($str) {
  return 0 if $str =~ /[iol]/;
  return 0 unless $str =~ /(.)\1/g && $str =~ /\G.*([^$1])\1/g;

  my @chars = map {; ord } split //, $str;
  my $diffs = join q{}, map {;
    my $x = $chars[$_+1] - $chars[$_];
    $x = 'x' unless $x == 1;
    $x
  } (0 .. $#chars - 1);
  return 0 if $diffs !~ /11/;

  return 1;
}

sub next_password {
  $seed++;
  return $seed if is_okay($seed);
  goto &next_password;
}

for (1..3) {
  say next_password();
}
