# Martlet

Martlet is a Ruby client for McGill's student portal, Minerva. Minerva sucks and constantly checking your grades sucks even more.

## Installation

Add this line to your application's Gemfile:

    gem 'martlet'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install martlet

## Usage

### Ruby

    $ irb
    >> require 'martlet'
    >> client = Martlet.new('your.name@mail.mcgill.ca', 'topsecret')
    >> pp client.grades
    {"COMP 206"=>"A",
     "COMP 250"=>"A"
     ...

### Shell

    $ martlet grades
    Minerva email: your.name@mail.mcgill.ca
    Password:
    Authenticating...
    Fetching grades...
    COMP 206: A
    COMP 250: A
    ...

Store your credentials in ~/.martlet to avoid typing them every time

    $ cat ~/.martlet
    email: 'your.name@mail.mcgill.ca'
    password: 'topsecret'
    $ martlet grades
    Authenticating...
    Fetching grades....
    ...