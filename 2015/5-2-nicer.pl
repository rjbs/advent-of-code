use rjbs;

my $total = 0;

while (<>) {
  chomp;
  my $nice = is_nice($_);
  say $nice;
  $total += $nice;
}

say "total: $total";

sub is_nice ($str) {
  return 0 unless $str =~ /([a-z]{2}).*\1/;
  return 0 unless $str =~ /([a-z]).\1/;
  return 1;
}
