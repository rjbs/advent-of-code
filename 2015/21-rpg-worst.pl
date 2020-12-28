#!perl
use rjbs;

my $hp = 100;
my %boss = (
  hp     => 100,
  damage => 8,
  armor  => 2,
);

use constant {
  GOLD    => 0,
  DAMAGE  => 1,
  ARMOR   => 2,
};

my %weapon = (
  Dagger       => [ qw( 8     4       0 )],
  Shortsword   => [ qw(10     5       0 )],
  Warhammer    => [ qw(25     6       0 )],
  Longsword    => [ qw(40     7       0 )],
  Greataxe     => [ qw(74     8       0 )],
);

my %armor = (
  None         => [ 0,0,0 ],
  Leather      => [ qw( 13     0       1 )],
  Chainmail    => [ qw( 31     0       2 )],
  Splintmail   => [ qw( 53     0       3 )],
  Bandedmail   => [ qw( 75     0       4 )],
  Platemail    => [ qw(102     0       5 )],
);

my %ring = (
  'None1'      => [ 0,0,0,],
  'None2'      => [ 0,0,0,],
  'Damage +1'  => [ qw(  25     1       0 )],
  'Damage +2'  => [ qw(  50     2       0 )],
  'Damage +3'  => [ qw( 100     3       0 )],
  'Defense +1' => [ qw(  20     0       1 )],
  'Defense +2' => [ qw(  40     0       2 )],
  'Defense +3' => [ qw(  80     0       3 )],
);

my $min = 0;
# my $max = 74 + 102 + 80 + 100;

while (my ($wname, $weapon) = each %weapon) {
  my %self = (spent => 0, damage => 0, armor => 0);

  $self{spent}  += $weapon->[GOLD];
  $self{damage} += $weapon->[DAMAGE];
  $self{armor}  += 0;

  while (my ($aname, $armor) = each %armor) {
    local $self{spent} = $self{spent} + $armor->[GOLD];
    local $self{armor} = $self{armor} + $armor->[ARMOR];

    for my $ring1 (keys %ring) {
      local $self{spent}  = $self{spent}  + $ring{$ring1}->[GOLD];
      local $self{armor}  = $self{armor}  + $ring{$ring1}->[ARMOR];
      local $self{damage} = $self{damage} + $ring{$ring1}->[DAMAGE];

      RING: for my $ring2 (grep { $_ ne $ring1 } keys %ring) {
        local $self{spent}  = $self{spent} + $ring{$ring2}->[GOLD];
        local $self{armor}  = $self{armor} + $ring{$ring2}->[ARMOR];
        local $self{damage} = $self{damage} + $ring{$ring2}->[DAMAGE];

        next if $self{spent} <= $min;

        my $atak = $self{damage} - $boss{armor};
        my $take = $boss{damage} - $self{armor};
        $atak = 1 if $atak < 1;
        $take = 1 if $take < 1;

        my $boss_hp = $boss{hp};
        my $self_hp = $hp;

        for (1 .. 20000) {
          $boss_hp -= $atak;
          if ($boss_hp <= 0) {
            next RING;
          }

          $self_hp -= $take;
          if ($self_hp <= 0) {
            say "$self{spent}gp -> $wname, $aname, $ring1, $ring2 @ $_";
            say "  Attack $atak, Take $take; I'm at $self_hp, boss at $boss_hp";
            $min = $self{spent};
            next RING;
          }
        }
      }
    }
  }
}

say $min;
