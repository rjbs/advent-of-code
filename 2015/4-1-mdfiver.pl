use rjbs;
use Digest::MD5 qw(md5_hex);

my $count = $ARGV[0];
my $base  = $ARGV[1];

my $i = 0;
while (++$i) {
  my $str = "$base$i";
  my $md5 = md5_hex($str);
  next unless $md5 =~ /^0{$count}/;
  print "$i -> $str -> $md5\n";
  last;
}
