# KUNIRI

[![Build Status](https://travis-ci.org/rodrigosiqueira/kuniri.svg?branch=master)](https://travis-ci.org/rodrigosiqueira/kuniri)
[![Code Climate](https://codeclimate.com/github/rodrigosiqueira/kuniri/badges/gpa.svg)](https://codeclimate.com/github/rodrigosiqueira/kuniri)
[![Stories in Ready](https://badge.waffle.io/rodrigosiqueira/kuniri.png?label=ready&title=Ready)](https://waffle.io/rodrigosiqueira/kuniri)

----
# What is Kuniri?

> The main objective of Kuniri is providing a way to dynamically generate 
diagrams and traceability based on the code. Kuniri will inspect the source 
code, extract the necessary information to generate diagrams and provide the 
traceability. This file is similar to XML file, and follows a strong pattern. 
This feature gives flexibility for other tools read the file and generate the 
diagram. It means, that Kuniri is NOT a graphic tool it is extract tool. 

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
# Author

* Rodrigo Siqueira de Melo
 * rodrigosiqueiramelo@gmail.com
