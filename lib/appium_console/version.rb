# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '0.5.8' unless defined? ::Appium::Console::VERSION
  DATE = '2014-01-27' unless defined? ::Appium::Console::DATE
end