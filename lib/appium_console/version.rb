# frozen_string_literal: true

# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '4.4.0' unless defined? ::Appium::Console::VERSION
    DATE = '2026-11-22' unless defined? ::Appium::Console::DATE # x-release-please-date
  end
end
