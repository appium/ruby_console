# frozen_string_literal: true

# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '3.1.0' unless defined? ::Appium::Console::VERSION
    DATE = '2022-11-13' unless defined? ::Appium::Console::DATE
  end
end
