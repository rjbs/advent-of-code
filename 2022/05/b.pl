#!/usr/bin/perl
use v5.36.0;

my @lines = <<>>;
chomp @lines;

my @header;
while (my $line = shift @lines) {
  last if $line eq '';
  push @header, $line;
}

my %stack_at;

sub dump_stack {
  for my $i (sort {; $a <=> $b } keys %stack_at) {
    say "$i: @{$stack_at{$i}}";
  }
}

my $index_line = pop @header;
for my $i (0 .. length($index_line) - 1) {
  my $j = substr $index_line, $i, 1;
  next unless $j =~ /\S/;;

  my @chars = reverse grep {; /\S/ } map {; substr $_, $i, 1 } @header;

  $stack_at{$j} = \@chars;

  say "col $j is at index $i: @chars";
}

for my $instr (@lines) {
  my ($c, $f, $t) = $instr =~ /\Amove (\d+) from (\d+) to (\d+)\z/a;

  my @stack;
  push $stack_at{$t}->@*, (splice $stack_at{$f}->@*, -$c);

  dump_stack();
  say '--';
}

dump_stack();
