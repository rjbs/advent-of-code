#!perl
use rjbs;

my %sue;

while (<>) {
  chomp;
  my ($num, $rest) = /^Sue ([0-9]+): (.+)$/;
  my @props = split /,\s*/, $rest;
  for (@props) {
    my ($n, $v) = split /:\s+/;
    $sue{$num}{$n} = $v;
  }
}

my %spec = (
  children    => [ eq => 3 ],
  cats        => [ eq => 7 ],
  samoyeds    => [ eq => 2 ],
  pomeranians => [ lt => 3 ],
  akitas      => [ eq => 0 ],
  vizslas     => [ eq => 0 ],
  goldfish    => [ lt => 5 ],
  trees       => [ gt => 3 ],
  cars        => [ gt => 2 ],
  perfumes    => [ eq => 1 ],
);

my %comp = (
  eq => sub { $_[0] == $_[1] },
  gt => sub { $_[0]  > $_[1] },
  lt => sub { $_[0]  < $_[1] },
);

for my $item (keys %spec) {
  my $value = $spec{$item}[1];
  my $comp  = $comp{ $spec{$item}[0] };

  for my $num (keys %sue) {
    delete $sue{$num} if exists $sue{$num}{$item}
                      && ! $comp->($sue{$num}{$item}, $value);
  }
}

use Data::Dumper;
say Dumper(\%sue);
