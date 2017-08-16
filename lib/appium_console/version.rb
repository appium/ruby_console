# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '2.4.0' unless defined? ::Appium::Console::VERSION
  DATE = '2017-08-16' unless defined? ::Appium::Console::DATE
end
