package SequencesDB::Schema::ResultSet::Library;

use strict;
use warnings;
use feature 'say';
use base 'DBIx::Class::ResultSet';

sub search_library {
    my ( $self, $user_input, $column, $type ) = @_;

    my $where = {};
    if ( $type =~ /equal/i ) {
        $where = { $column => $user_input };
    }
    elsif ( $type =~ /similar/i ) {
        $where = { $column => { like => "%$user_input%" } };
    }

    my $rs = $self->search(
        $where,
        {
            prefetch => [
                'organism_organism',     'tissue_tissue',
                'cell_cell',             'experiment_experiment',
                'background_background', 'method_method',
                'antibody_antibody',     'sequencer_sequencer',
                'files_inner'
            ],
        }
    );
    return $rs;
}

1;
