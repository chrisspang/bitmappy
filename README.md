# Bitmappy

[![Build Status](https://travis-ci.org/chrisspang/bitmappy.svg?branch=master)](https://travis-ci.org/chrisspang/bitmappy)

## Installation (rvm)

Install ruby 2.0, create temporary gemset, etc:

    $ rvm install 2.0
    $ rvm use 2.0
    $ rvm gemset create testytest
    $ rvm gemset use testytest

    $ gem install bundler
    $ bundle

Run tests if you so desire:    
    
    $ rake test

As desired, some combination of:

    $ rake build
    $ rake install

Then play with bitmappy:

$ bitmappy
> I 5 6
> L 2 3 A
> S
OOOOO
OOOOO
OAOOO
OOOOO
OOOOO
OOOOO
> F 3 3 J
> V 2 3 4 W
> H 3 4 2 Z
> S
JJJJJ
JJZZJ
JWJJJ
JWJJJ
JJJJJ
JJJJJ
> X

## Extra Feature

This version of the basic interactive bitmap editor has an exciting new feature.. UNDO!

Use the command 'U' command to roll back your last changes, all the way back to your first
bitmap creation ('I' command).  Use it once, use it forever (or until you run out of memory).

Example:

```
> I 10 10
> F 1 1 I
> H 1 10 1 A
> H 1 10 10 A
> V 1 1 10 A
> V 10 10 1 A
> H 3 8  3 B
> H 3 8 8 B
> V 3 3 8 B
> V 8 8 3 B
> F 5 5 X
> S
AAAAAAAAAA
AIIIIIIIIA
AIBBBBBBIA
AIBXXXXBIA
AIBXXXXBIA
AIBXXXXBIA
AIBXXXXBIA
AIBBBBBBIA
AIIIIIIIIA
AAAAAAAAAA
> C
```

 OOPS!

```
> S
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
OOOOOOOOOO
> U
> S
AAAAAAAAAA
AIIIIIIIIA
AIBBBBBBIA
AIBXXXXBIA
AIBXXXXBIA
AIBXXXXBIA
AIBXXXXBIA
AIBBBBBBIA
AIIIIIIIIA
AAAAAAAAAA
```

 YAY!

 You can keep going if you like:

```
> U
> U
> U
> U
> U
> S
AAAAAAAAAA
AIIIIIIIII
AIIIIIIIII
AIIIIIIIII
AIIIIIIIII
AIIIIIIIII
AIIIIIIIII
AIIIIIIIII
AIIIIIIIII
AAAAAAAAAA
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

