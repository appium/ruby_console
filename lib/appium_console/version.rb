# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '0.5.3' unless defined? ::Appium::Console::VERSION
  DATE = '2013-08-07' unless defined? ::Appium::Console::DATE
end