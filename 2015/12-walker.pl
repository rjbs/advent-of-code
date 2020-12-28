use rjbs;
use JSON;

my $input = do { local $/; <> };
my $data  = JSON->new->decode($input);

my $sum = 0;

sub walk_data ($data) {
  if (ref $data eq 'HASH' )   {
    return $sum if grep {; $_ eq 'red' } values %$data;
    walk_data($_) for values %$data;
  }
  if (ref $data eq 'ARRAY')   { walk_data($_) for values @$data; }
  if ($data =~ /\A-?[0-9.]+\z/) { $sum += $data }
  return $sum;
}

say walk_data($data);
