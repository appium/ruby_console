# encoding: utf-8
#
# run with
# ruby my_test.rb

$:.unshift File.expand_path('..', __FILE__)

require 'console'

def sign_in
  button('Sign In').click
end
