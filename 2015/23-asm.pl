#!perl
use rjbs;

my @instr = <>;
chomp @instr;
my $pc = 0;

my %reg = (a => 1, b => 0);
my $O_RE = qr/[+-][0-9]+/;

while ($pc < @instr) {
  local $_ = $instr[$pc];
  say "A: $reg{a} B: $reg{b} PC: $pc // $_";

  if (0) { ... }
  elsif (/hlf (a|b)/) { $reg{$1} = $reg{$1} / 2; $pc++}
  elsif (/tpl (a|b)/) { $reg{$1} *= 3;           $pc++}
  elsif (/inc (a|b)/) { $reg{$1}++;              $pc++}

  elsif (/jmp ($O_RE)/) { $pc += $1 }
  elsif (/jie (a|b), ($O_RE)/) { $pc += $reg{$1} % 2 == 0 ? $2 : 1 }
  elsif (/jio (a|b), ($O_RE)/) { $pc += $reg{$1}     == 1 ? $2 : 1 }
  else { die "WTF: <$_>" }
}

say "A: $reg{a} B: $reg{b} // TERMINATE";
