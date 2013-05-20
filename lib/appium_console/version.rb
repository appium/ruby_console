# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '0.3.6' unless defined? ::Appium::Console::VERSION
  DATE = '2013-05-20' unless defined? ::Appium::Console::DATE
end