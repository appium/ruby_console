# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '0.5.0' unless defined? ::Appium::Console::VERSION
  DATE = '2013-05-24' unless defined? ::Appium::Console::DATE
end