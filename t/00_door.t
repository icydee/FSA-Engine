#!/home/docherti/perl5/perlbrew/perls/perl-5.12.4/bin/perl
use strict;
use warnings;

use FindBin::libs;
use Door;

my $door = Door->new({
    dfa_state => 'locked',
});

print "door = [$door]\n";

# door is closed and locked
print "TURN KEY CLOCKWISE\n";
$door->dfa_check_state('TURN KEY CLOCKWISE');
# door is closed and unlocked
print "TURN KEY ANTICLOCKWISE\n";
$door->dfa_check_state('TURN KEY ANTICLOCKWISE');
# door is closed and locked
print "TURN KEY ANTICLOCKWISE\n";
$door->dfa_check_state('TURN KEY ANTICLOCKWISE');
# door is still closed and locked
print "TURN KEY CLOCKWISE\n";
$door->dfa_check_state('TURN KEY CLOCKWISE');
# door is unlocked
print "PUSH DOOR\n";
$door->dfa_check_state('PUSH DOOR');
# door does not move
print "PULL DOOR\n";
$door->dfa_check_state('PULL DOOR');
# door pulls open
print "TURN KEY CLOCKWISE\n";
$door->dfa_check_state('TURN KEY CLOCKWISE');
# nothing happens
print "TURN KEY ANTICLOCKWISE\n";
$door->dfa_check_state('TURN KEY ANTICLOCKWISE');
# nothing happens
print "PULL DOOR\n";
$door->dfa_check_state('PULL DOOR');
# nothing happens
print "PuSh DoOr\n";
$door->dfa_check_state('PuSh DoOr');
# the door is closed
print "PULL DOOR\n";
$door->dfa_check_state('PULL DOOR');
# the door is open
print "SHOVE DOOR\n";
$door->dfa_check_state('SHOVE DOOR');
# the door is closed
1;
