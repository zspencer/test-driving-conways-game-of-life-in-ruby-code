# Test Driving Conways Game of Life in Ruby Code

This respository contains the code for the book, _Test Driving Conways Game of
Life in Ruby_. Essentially, this is a stream of consciousness approach to test
driving conways game of life in an outside-in manner.

The commits are intended to be read in order, from oldest to newest. Each
commit will either be prefixed with RED, GREEN, or REFACTOR to indicate which
step in the TDD cycle the commit was written for.

## Getting Started on OS X or Linux

These instructions are for people using OS X or Linux. Instructions for Windows
are forthcoming.

### Set Up Your Computer
Open up a [terminal](http://glossary.codeunion.io/terminal) and run the
following commands:

* `which git` - Checks if you have the version control system
  [Git](http://glossary.codeunion.io/git) installed. If Git is installed this
  command will print something like `/usr/local/bin/git`. If it prints nothing,
  you should [install
  git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* `which ruby` - Checks if you have the programming language
  [Ruby](http://glossary.codeunion.io/ruby) installed.  If Ruby is installed it
  will print something like `/usr/bin/ruby`.  If it prints nothing, you should
  [install ruby](https://www.ruby-lang.org/en/installation/).
* `which bundle` - Checks if you have the Ruby package manager
  [Bunder](http://bundler.io) installed. It should print something like
  `/usr/bin/bundle`. If it prints nothing, you will need to run `gem install
  bundler`. If `gem install bundler` fails, you will need to run `sudo gem
  install bundler` and enter your computer's password when prompted.
* `bundle install` - Has Bundler install all the
  [gems](http://glossary.codeunion.io/gem) listed in this project's `Gemfile`.
  This may prompt you for your computer password. If so, fill it in.


### Walk Through The Commits
Four programs have been provided to walk through the [commits](http://glossary.codeunion.io/commit-git):

* `bin/rewind` - Takes you to the first commit and prints the commit message.
* `bin/previous` - Takes you back a commit, prints the commit message and runs
  the tests.
* `bin/next` - Takes you to the next commit, prints the commit message and runs
  the tests.
* `bin/fastforward` - Takes you to the end of the commits.

## Technology

I chose [minitest](https://github.com/seattlerb/minitest), as I believe it
encourages expressive code outside of a testing DSL designed for
expressiveness.

I am intentionally writing this for ruby 1.8.7+ to make it easy for people with
system ruby to get started.
