# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '0.5.2' unless defined? ::Appium::Console::VERSION
  DATE = '2013-07-26' unless defined? ::Appium::Console::DATE
end