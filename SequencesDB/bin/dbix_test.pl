#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use SequencesDB::Schema;
use Data::Printer
my $schema = SequencesDB::Schema->connect('dbi:mysql:sequences_dtb', 'root', '2hest9hu');

my $user_input = 'mouse';
my $column = 'organism_organism.organism_name';
my $type = 'similar';

my $rs = $schema->resultset('Library')->get_big_table( $user_input, $column, $type );
