$:.unshift File.expand_path('..', __FILE__)

require 'console'

def sign_in
  button('Sign In').click
end
