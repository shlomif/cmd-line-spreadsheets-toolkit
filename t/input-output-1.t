#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;
use Test::Differences (qw( eq_or_diff ));
use IO::All qw/ io /;
use File::Temp qw/ tempdir /;

my $dirname = tempdir( CLEANUP => 1 );

{
    my $INPUT1 = <<"EOF";
Time\tIterations\tDelta\tHeight
5\t100\t6\t16
10\t200\t10\t20
15\t260\t7\t24
EOF

    my $i1 = io()->file("$dirname/input");
    $i1->print($INPUT1);
    $i1->close;

    my $o1 = io->file("$dirname/output");

    system("./bin/select-fields -f Time -f Delta < @{[$i1->absolute->pathname]} > @{[$o1->absolute->pathname]}");
    eq_or_diff($o1->all, <<"EOF", "select-fields works fine");
Time\tDelta
5\t6
10\t10
15\t7
EOF
}

