# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '2.0.2' unless defined? ::Appium::Console::VERSION
  DATE = '2016-09-23' unless defined? ::Appium::Console::DATE
end
