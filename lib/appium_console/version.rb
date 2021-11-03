# frozen_string_literal: true

# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '2.13.0' unless defined? ::Appium::Console::VERSION
    DATE = '2021-01-25' unless defined? ::Appium::Console::DATE
  end
end
