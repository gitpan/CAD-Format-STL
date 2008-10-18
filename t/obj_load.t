#!/usr/bin/perl

use warnings;
use strict;

use Test::More 'no_plan';

use CAD::Format::STL;

my $stl = CAD::Format::STL->new or die "ack";
my $file = 'files/cube.stl';
{
  my $check = eval {$stl->load($file)};
  ok(not $@) or die $@;
  is($check, $stl);
}

my @parts = $stl->parts;
is(scalar(@parts), 1, 'one part');

my $part = $parts[0];
is($part->name, 'cube', 'part name');
is(scalar($part->facets), 12, 'twelve triangles');

{
  my $check = $stl->part(0);
  is($check, $part, 'got part 0');
  eval {$stl->part(1)};
  like($@, qr/no part/, 'nothing there');
  is($stl->part(-1), $part, 'got part -1');
  eval {$stl->part(-2)};
  like($@, qr/no part/, 'nothing there');
}

# vim:ts=2:sw=2:et:sta
