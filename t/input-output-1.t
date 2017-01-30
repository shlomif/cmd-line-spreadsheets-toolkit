#!/usr/bin/perl

=head1 TODD:

* IO::All has no ->flush method.

* $i1->autoflush(1) did not work.

* io->temp()->absolute->pathname() did not work.

=cut

use strict;
use warnings;

use Test::More tests => 2;
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

    system(
"./bin/select-fields -f Time -f Delta < @{[$i1->absolute->pathname]} > @{[$o1->absolute->pathname]}"
    );

    # TEST
    eq_or_diff( $o1->all, <<"EOF", "select-fields works fine" );
Time\tDelta
5\t6
10\t10
15\t7
EOF
}

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

    system(
qq#./bin/accum-field -f ItersSum=0 -e '\$N{ItersSum} += \$F{Iterations}' < @{[$i1->absolute->pathname]} > @{[$o1->absolute->pathname]}#
    );

    # TEST
    eq_or_diff( $o1->all, <<"EOF", "select-fields works fine" );
Time\tIterations\tDelta\tHeight\tItersSum
5\t100\t6\t16\t100
10\t200\t10\t20\t300
15\t260\t7\t24\t560
EOF
}
