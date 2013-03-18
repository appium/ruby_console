# encoding: utf-8
#
# run with
# ruby my_test.rb
#
# Example use of running a test standalone. Useful for debugging a single test.

$:.unshift File.expand_path('..', __FILE__)

require 'console'

def sign_in
  button('Sign In').click
end

sign_in
