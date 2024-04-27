# frozen_string_literal: true

# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '4.1.1' unless defined? ::Appium::Console::VERSION
    DATE = '2024-04-26' unless defined? ::Appium::Console::DATE
  end
end
