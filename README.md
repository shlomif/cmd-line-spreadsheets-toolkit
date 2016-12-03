# cmd-line-spreadsheets-toolkit

The Command Line Spreadsheets Toolkit.

This repository aims to develop documentation and tools for how to interact
with [spreadsheets](https://en.wikipedia.org/wiki/Spreadsheet) on the
[command line interface (“CLI”)](https://en.wikipedia.org/wiki/Command-line_interface)
of Unix-like systems such as Linux. By command line we do not mean
[“terminal user interface” (TUI)](https://en.wikipedia.org/wiki/Text-based_user_interface)
which means that one invokes a full terminal spreadsheet program such as
[“GNU Oleo”](https://en.wikipedia.org/wiki/GNU_Oleo) or
[sc](https://github.com/dkastner/sc), but rather a way to generate,
manipulate and chart simple spreadsheets semi-automatically and
directly on the Unix command line.

[![Build Status](https://travis-ci.org/shlomif/cmd-line-spreadsheets-toolkit.svg?branch=master)](https://travis-ci.org/shlomif/cmd-line-spreadsheets-toolkit)

# Screenshots

![Image](<http://i.imgur.com/CiJRyM9.png>)

# TSV (Tab-separated values) as the Standard Format

The discussion here will assume one uses [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) as the standard intermediate exchange format in
processing the spreadsheets. What it means is that every row is in a text line
terminated by a [linefeed (LF)](https://en.wikipedia.org/wiki/Newline) character
(“\n”) and contains a fixed (for the spreadsheet) number of fields separated
by a tab character (“\t”), which themselves cannot contain it.

Some spreadsheets may contain a row of names or titles for the columns, and
you should know if that is the case for them or not.

## Tasks

### Removing the header/title/name line/row

One can use:

```
tail -n +2
perl -lnE 'say if $. > 1'
ruby -lne 'puts $_ if $. > 1'
```

For example:

```
$ echo -n $'Time\tValue\n5\t100\n10\t200\n'
Time    Value
5       100
10      200
$ echo -n $'Time\tValue\n5\t100\n10\t200\n' | tail -n +2
5       100
10      200
$ echo -n $'Time\tValue\n5\t100\n10\t200\n' | perl -lnE 'say if $. > 1'
5       100
10      200
$ echo -n $'Time\tValue\n5\t100\n10\t200\n' | ruby -lne 'puts $_ if $. > 1'
5       100
10      200
$
```

### Extracting certain fields based on their titles

One can use:

```
./bin/select-fields -f Time -f Iterations
```

For example:

```
$ echo -n $'Time\tValue\tIterations\n5\t2000\t100\n10\t-34\t200\n'
Time    Value   Iterations
5       2000    100
10      -34     200
$ echo -n $'Time\tValue\tIterations\n5\t2000\t100\n10\t-34\t200\n' | ./bin/select-fields -f Time -f Iterations
Time    Iterations
5       100
10      200
$
```

### Creating a chart

One can use [svg-graph](https://github.com/shlomif/perl-App-SVG-Graph)
for that. There is also [victory-cli](https://github.com/FormidableLabs/victory-cli) but it does not seem to accept TSV.

### Merging columns from two-or-more different sources

One can use the [paste](https://en.wikipedia.org/wiki/Paste_%28Unix%29) command
to merge two or more spreadsheets side by side, while possibly utilising
Bash’s `<(...)` notation:

```
$ paste <(echo -n $'Time\tIters\n1\t100\n') <(echo -n $'Delta\n25\n')
Time    Iters   Delta
1       100     25
```

### Concatenating two datasets

One can use the [cat](https://en.wikipedia.org/wiki/Cat_%28Unix%29) command
to concatenate two data sets, or simply write several output commands one
after the other using `;`. E.g:

```
$ cat foo.tsv bar.tsv baz.tsv | svg-graph
$ (gen1 ; gen2 ; gen3) | svg-graph
```

### Determining the number of rows and columns

One can use `wc -l` to determine the number of rows (including the optional
header) and `perl -laF'/\t/'pE '$_=@F' | uniq` to determine the number of
columns.

### Running sum/product/accumulated column.


