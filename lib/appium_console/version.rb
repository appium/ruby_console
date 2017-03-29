# encoding: utf-8
# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium::Console
  VERSION = '2.1.1' unless defined? ::Appium::Console::VERSION
  DATE = '2017-03-30' unless defined? ::Appium::Console::DATE
end
