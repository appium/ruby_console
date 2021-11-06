# frozen_string_literal: true

# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '3.0.0' unless defined? ::Appium::Console::VERSION
    DATE = '2021-11-06' unless defined? ::Appium::Console::DATE
  end
end
