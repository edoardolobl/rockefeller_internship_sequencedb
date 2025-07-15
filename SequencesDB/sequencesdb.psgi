use strict;
use warnings;

use SequencesDB;

my $app = SequencesDB->apply_default_middlewares(SequencesDB->psgi_app);
$app;

