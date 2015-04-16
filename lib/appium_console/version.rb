# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '1.0.4' unless defined? ::Appium::Console::VERSION
  DATE = '2015-04-16' unless defined? ::Appium::Console::DATE
end