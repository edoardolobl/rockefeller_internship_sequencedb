#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../SequencesDB/lib";

use SequencesDB::Schema;

# Coloque as credenciais corretas aqui
my $dsn = "dbi:mysql:sequences_dtb";
my $user = "root";
my $password = "2hest9hu"; # <-- COLOQUE SUA SENHA REAL AQUI

print "Conectando ao banco de dados...\n";
my $schema = SequencesDB::Schema->connect($dsn, $user, $password);

print "Criando tabelas no banco de dados 'sequences_dtb'...\n";
$schema->deploy(); # Este comando cria as tabelas

print "Tabelas criadas com sucesso!\n";

1;