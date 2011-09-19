package MooseX::FSA::Simple::Transition;
#
# A transition taking place in MooseX::FSA::Simple
#
use Moose;

has 'test'  => (
    is          => 'rw',
    required    => 1,
);

has 'action'    => (
    is          => 'rw',
);

has 'state'     => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);


# Test against an input value
#
sub do_test {
    my ($self, $input) = @_;

    if ((ref $self->test) eq 'CODE') {
        my $ret_val = &{$self->test}($input);
        return $ret_val;
    }
    return $input eq $self->test;
}

1;
