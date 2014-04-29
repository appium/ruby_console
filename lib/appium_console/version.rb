# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '1.0.0' unless defined? ::Appium::Console::VERSION
  DATE = '2014-04-29' unless defined? ::Appium::Console::DATE
end