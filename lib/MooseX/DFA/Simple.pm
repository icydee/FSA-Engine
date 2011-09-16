package MooseX::DFA::Simple;
#
# Simple implementation of a Deterministic Finite-state Automata
#
use Moose::Role;
use MooseX::DFA::Simple::Transition;

# The states table, with option entry and exit actions
#
has 'dfa_states' => (
    is          => 'rw',
    isa         => 'HashRef',
    lazy_build  => 1,
    builder     => '_build_dfa_states',
);

# The transitions table, from state to state, with test conditions and transition actions
#
has 'dfa_transitions' => (
    is          => 'rw',
    isa         => 'HashRef',
    lazy_build  => 1,
    builder     => '_build_dfa_transitions',
);

# The current state of the DFA
#
has 'dfa_state' => (
    is          => 'rw',
    required    => 1,
    trigger     => \&_dfa_state_trigger,
);

# The current input value
#
has 'dfa_input' => (
    is          => 'rw',
);

# The dfa_state change trigger
#
sub _dfa_state_trigger {
    my ( $self, $new_state, $old_state ) = @_;

    if (not $old_state or $new_state ne $old_state) {
        my $state_actions = $self->dfa_states->{$new_state};
        if ($state_actions and $state_actions->{entry_action}) {
            &{$state_actions->{entry_action}};
        }
    }
}


# do the DFA State Change checks
#
sub dfa_check_state {
    my ($self, $input) = @_;

    $self->dfa_input($input) if defined $input;

    # Do the transition tests for the current state
    my $state_transitions = $self->dfa_transitions->{$self->dfa_state};

    for my $transition_name (keys %$state_transitions) {
        my $transition = $state_transitions->{$transition_name};
        if ($transition->do_test($self->dfa_input)) {
            # test succeeded, carry out transition
            # First the leaving action (if any) of the current state
            my $state_actions = $self->dfa_states->{$self->dfa_state};
            if ($state_actions and $state_actions->{exit_action}) {
                &{$state_actions->{exit_action}};
            }

            # Now carry out the transition action (if any)
            if ($transition->action) {
                &{$transition->action}($self->dfa_input);
            }

            # Change the state (note: the entry action will be carried
            # out by virtue of the trigger, this ensures that the entry
            # action is always done even when the dfa_state is changed
            # manually or during construction.)
            $self->dfa_state($transition->state);

            # return the new state
            return $self->dfa_state;
        }
    }
    # no state change occurred
    return;
}

1;
