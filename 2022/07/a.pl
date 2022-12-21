#!/usr/bin/perl
use v5.36.0;

my @input = <<>>;
chomp @input;

my %root = ( _size => 0, _name => '' );
my @path = (\%root);
my %dirs = ('/' => \%root);

die unless $input[0] eq '$ cd /';
shift @input;

LINE: while (@input) {
  my $line = shift @input;

  if ($line eq '$ ls') {
    # warn "ls\n";
    my @output;
    while (@input && $input[0] !~ /\A\$/) {
      my ($data, $name) = split /\s+/, (shift @input);
      if ($data eq 'dir') {
        warn "ls -> dir $name\n";

        if ($path[-1]{$name}) {
          warn "  reentry, skip\n";
          next LINE;
        }

        $path[-1]{$name} //= { _name => $name, _size => 0 };

        my $fullname = join(q{/}, (map {; $_->{_name} } @path), $name);
        $fullname = '/' unless length $fullname;

        warn "  setting ref for $fullname ($name) ($path[-1]{$name}{_name})\n";
        $dirs{$fullname} //= $path[-1]{$name};
      } else {
        next if defined $path[-1]{$name};
        warn "ls -> file $name\n";
        $path[-1]{$name} = $data;
        $_->{_size} += $data for @path;
        warn "++ $data on $_->{_name} (now $_->{_size})\n" for @path;
      }
    }

    next LINE;
  }

  if ($line eq '$ cd ..') {
    pop @path;

    # my $size = $path[-1]{_size};
    # warn "CWD: " . join(q{/}, map {; $_->{_name} } @path) . " ($size)\n";

    next LINE;
  }

  if ($line =~ /\A\$ cd (\S+)$/) {
    die "?!" unless $path[-1]{$1};
    push @path, $path[-1]{$1};

    # my $size = $path[-1]{_size};
    # warn "CWD: " . join(q{/}, map {; $_->{_name} } @path) . " ($size)\n";

    next LINE;
  }

  warn "weird line: $line\n";
}

use Data::Dumper::Concise;
warn Dumper(\%dirs);

if (1) {
  my @keys = keys %dirs;
  say "$_ - $dirs{$_}{_size}" for sort @keys;
}

my @keys = grep {; $dirs{$_}{_size} <= 100_000 } keys %dirs;

say "$_ - $dirs{$_}{_size}" for sort @keys;

my $total = 0;
$total += $dirs{$_}{_size} for @keys;

say $total;

say "Total space: 70000000";
say "Space used : $dirs{'/'}{_size}";

my $free = 70000000 - $dirs{'/'}{_size};

say "Space free : $free";

my $need = 30000000 - $free;
say "Must free  : $need";

{
  my @keys = grep {; $dirs{$_}{_size} >= $need } keys %dirs;
  say "$_ - $dirs{$_}{_size}" for sort {; $dirs{$a}{_size} <=> $dirs{$b}{_size}
  } @keys;
}
