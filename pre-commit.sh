#!/bin/sh

# Can use this in an IDE it can't load rvm environment.
# and charge the rvm environment.
# When you use git only in shell commands, ruby script 'pre-commit.rspec.rb' is enough. You only need to move it to pre-commit.
# If you want use this, move it to pre-commit, otherwise move pre-commit.rspec.rb to pre-commit.

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

rvm reload > /dev/null

# List pre-commit hook files here
rvm-auto-ruby .git/hooks/pre-commit.flog.rb
