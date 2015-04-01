# KUNIRI

[![Build Status](https://travis-ci.org/rodrigosiqueira/kuniri.svg?branch=master)](https://travis-ci.org/rodrigosiqueira/kuniri)
[![Code Climate](https://codeclimate.com/github/rodrigosiqueira/kuniri/badges/gpa.svg)](https://codeclimate.com/github/rodrigosiqueira/kuniri)
[![Test Coverage](https://codeclimate.com/github/rodrigosiqueira/kuniri/badges/coverage.svg)](https://codeclimate.com/github/rodrigosiqueira/kuniri)
[![Stories in Ready](https://badge.waffle.io/rodrigosiqueira/kuniri.png?label=ready&title=Ready)](https://waffle.io/rodrigosiqueira/kuniri)

----
# What is Kuniri?

> Briefely, the main object of Kuniri is: parse any kind of language to a
common model file. Initialily, the main objective of Kuniri was providing a way 
to dynamically generate diagrams and traceability based on code. However the
parse proved much more useful for many other kind of application, because of
this the focus changed to create the parse.

>Kuniri will inspect the source code, extract information to generate
diagrams and provide the traceability. This file is similar to XML file, and
follows a strong pattern. This feature gives flexibility for other tools read
the file and process anything they want.

> Additionally, Kuniri was designed to grow to three main directions: support 
for different languages, provide ways to monitoring the source, and provide 
options of extract the information.

----
## What is the the meaning of "kuniri"?

> Kuniri is an esperanto word, that mean "go with" or "follow". This name was 
chosen because of the idea to keep following your code project with diagrams 
and traceability.

----
# Development

* System Dependencies (Kubuntu/Ubuntu)
 * YARD 0.8
 * RSpec 3.1.7
 * Rake 10.4
 * Guard-rspec 4.2
* Ruby version: 2.1
* Run test suit
 * rake spec or spec
* YARD documentation
 * yardoc

----
# Install

Kuniri can be installed with
```
rake install
```

After installing you can check the commands with
```
kuniri -h
```

----
# How to use
If you want to use kuniri in your project, first you have to create ".kuniri"
file. The example below show the basic syntax:

```
language:ruby
source:lib/
output:bin/
extract:uml
```

Finally, you can navigate under your project with the command:

```
kuniri -i
```

-i means "iterative mode". After you entered into iterative mode you can type:

```
ls
```
This command will show all the files already parsed. After you take a look in
all the files, you can "enter" in some of the files for get more details:

```
cd <nameOfTheFile>
```

Inside of the file, you can take a look at the method or attributes with:

```
ls -a
ls -m
```

-a means "attribute" and -m "method", when you are inside of the file.

----
# Author

* Rodrigo Siqueira de Melo
 * rodrigosiqueiramelo@gmail.com
