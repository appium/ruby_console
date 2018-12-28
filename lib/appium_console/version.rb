# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '2.11.0'.freeze unless defined? ::Appium::Console::VERSION
    DATE = '2018-12-28'.freeze unless defined? ::Appium::Console::DATE
  end
end
