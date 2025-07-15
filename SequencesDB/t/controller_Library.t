use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SequencesDB';
use SequencesDB::Controller::Library;

ok( request('/library')->is_success, 'Request should succeed' );
done_testing();
