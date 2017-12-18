# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '2.8.0' unless defined? ::Appium::Console::VERSION
  DATE = '2017-12-18' unless defined? ::Appium::Console::DATE
end
