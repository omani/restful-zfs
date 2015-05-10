#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../restful-zfs";

my $t = Test::Mojo->new;


$t->get_ok('/api/v1/pools')->status_is(200)->json_has('/pools', 'Got an array of ZFS pool collections');
$t->get_ok('/api/v1/pool/tank')->status_is(200)->json_is('/pool/NAME' => 'tank', 'Got a ZFS pool collection named tank');

done_testing();