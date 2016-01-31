# KUNIRI

----

[![Join the chat at https://gitter.im/rodrigosiqueira/kuniri](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/rodrigosiqueira/kuniri?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/Kuniri/kuniri.svg?branch=master)](https://travis-ci.org/Kuniri/kuniri)
[![Code Climate](https://codeclimate.com/github/Kuniri/kuniri/badges/gpa.svg)](https://codeclimate.com/github/Kuniri/kuniri)
[![Stories in Ready](https://badge.waffle.io/Kuniri/kuniri.svg?label=ready&title=Ready)](http://waffle.io/Kuniri/kuniri)
[![Coverage Status](https://coveralls.io/repos/Kuniri/kuniri/badge.svg?branch=master&service=github)](https://coveralls.io/github/Kuniri/kuniri?branch=master)
[![Inline docs](http://inch-ci.org/github/Kuniri/kuniri.svg?branch=master)](http://inch-ci.org/github/Kuniri/kuniri)
[![Gem Version](https://badge.fury.io/rb/kuniri.svg)](http://badge.fury.io/rb/kuniri)
[![License](https://img.shields.io/badge/license-LGPLv3-green.svg)](https://github.com/Kuniri/kuniri/blob/master/COPYING)

----
# What is Kuniri?

<img src="https://github.com/kuniri/kuniri/wiki/logo/256px/with_round_border.png" alt="Kuniri" align="left" />
> Briefly, the main goal of Kuniri is: parse any kind of language, and generate
a common model file with code information. We believe that Kuniri can be a base
tool for other tools, like a diagram generator, traceability, code quality,
documentation, and so forth. Initially, the main objective of Kuniri was to
provide a way to dynamically generate diagrams and traceability based on code.
However, the parser proved much more useful for many other kinds of
applications; thus, the focus shifted to the parser creation.

> Kuniri will inspect the source code, and extract information to generate a
final output. This file is a XML file (and other types in the near future), and
follows a strong pattern. This feature gives flexibility to other tools read the
file and process anything they want.

> Additionally, Kuniri was designed to grow to two main directions: support for
different languages, and provide ways to select which kind of information to
extract from the code.

----
## What is the the meaning of "kuniri"?

> Kuniri is an Esperanto word which means "go with" or "follow". This name was
chosen because of the idea to keep following your code project with diagrams,
traceability, code quality and others.

----
# Development

* System Dependencies
 * YARD 0.8
 * RSpec 3.1.7
 * Rake 10.4
 * Guard-rspec 4.2
* Ruby version: 2.1

----
# Install

> Kuniri can be installed with:

```
rake install
```

> After installing you can check the commands with:

```
kuniri -h
```

> Or you can install the stable version with:

```
gem install kuniri
```

----
# How to use

> You have two different approaches to using kuniri: command line and
configuration file.

## Command line

> Command line is the practical and easy way to use kuniri. You just have to
use a similar command as the one described below:

```
kuniri path/to/your/source/code -o path/to/kuniri/output -l ruby
```

> First parameter is the source code path. ***"-o"***, means ***"output"*** and
you can indicate the path that you want to put the final output. Finally
***-l***, indicate which kind of language your project is.

## Using configuration file

> If you chose to use a configuration file, first you have to create
".kuniri.yml" file. The example below shows the basic syntax:

```
:language: ruby
:source: lib/
:output: bin/
```

> First parameter, ***"language"***, indicates what kind of language kuniri
will parse (unfortunately, we just have ruby language now). Second parameter
is ***"source"***, and it is used for specifying the target folder to be parsed
by kuniri. Finally the third parameter is ***"output"***, and you can use it to
indicate which folder kuniri will put the final output.

> Finally, you can execute kuniri with the command below:

```
kuniri -e [file_name_output.xml]
```

***-e*** means "extract mode".

# How to contact us?

You can contact us by:

1. Mailing list: https://groups.google.com/forum/#!forum/kuniri
2. Gitter: https://gitter.im/rodrigosiqueira/kuniri
3. Irc: Connect to freenode, at kuniri

----
# Author

* Rodrigo Siqueira de Melo
 * siqueira@kuniri.org
* Gustavo Jaruga
 * jaruga@kuniri.org
