# cmd-line-spreadsheets-toolkit

The Command Line Spreadsheets Toolkit.

This repository aims to develop documentation and tools for how to interact
with spreadsheets on the
[command line interface (“CLI”)](https://en.wikipedia.org/wiki/Command-line_interface)
of Unix-like systems such as Linux. By command line we do not mean
[“terminal user interface” (TUI)](https://en.wikipedia.org/wiki/Text-based_user_interface)
which means that one invokes a full terminal spreadsheet program such as
[“GNU Oleo”](https://en.wikipedia.org/wiki/GNU_Oleo) or
[sc](https://github.com/dkastner/sc), but rather a way to generate,
manipulate and chart simple spreadsheets semi-automatically and
directly on the Unix command line.

# TSV (Tab-separated values) as the Standard Format

The discussion here will assume one uses [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) as the standard intermediate exchange format in
processing the spreadsheets. What it means is that every row is in a text line
terminated by a [linefeed (LF)](https://en.wikipedia.org/wiki/Newline) character
(“\n”) and contains a fixed (for the spreadsheet) number of fields separated
by a tab character (“\t”), which themselves cannot contain it.

Some spreadsheets may contain a row of names or titles for the columns, and
you should know if that is the case for them or not.


