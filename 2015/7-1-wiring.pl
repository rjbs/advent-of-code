use rjbs;

my %source_for;

while (<>) {
  chomp;
  parse_line();
}

for my $wire (sort keys %source_for) {
  my $val = eval_wire($wire);
  say "$wire: $val";
}

sub eval_wire ($wire) {
  return $wire if $wire =~ /\A[0-9]+\z/;

  die "signal read on unwired wire $wire\n"
    unless defined (my $source = $source_for{$wire});

  if (ref $source) {
    $source = $source->();
    $source_for{$wire} = $source;
  }

  return $source;
}

our ($WIRE, $NUM, $WNUM);
BEGIN {
  $WIRE = qr/[a-z]+/;
  $NUM  = qr/[0-9]+/;
  $WNUM = qr/$WIRE|$NUM/;
}

sub binary ($op, $code) {
  if (my ($lhs, $rhs, $target) = /^($WNUM) $op ($WNUM) -> ($WIRE)$/) {
    $source_for{$target} = sub { $code->(eval_wire($lhs), eval_wire($rhs)) };
    return 1;
  }
}

sub parse_line {
  if (/^($WNUM) -> ($WIRE)$/)  {
    my $source = $1;
    $source_for{$2} = sub { eval_wire($source) };
    return;
  }

  if (/^NOT ($WIRE) -> ($WIRE)$/)  {
    my $source = $1;
    $source_for{$2} = sub { 65535 & ~ eval_wire($source) };
    return;
  }

  return if binary(AND    => sub ($l, $r) { $l & $r });
  return if binary(OR     => sub ($l, $r) { $l | $r });
  return if binary(LSHIFT => sub ($l, $r) { $l << $r });
  return if binary(RSHIFT => sub ($l, $r) { $l >> $r });

  die "can't understand line: $_\n";
}
