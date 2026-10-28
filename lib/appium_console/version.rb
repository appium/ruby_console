# frozen_string_literal: true

# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '4.3.1' unless defined? ::Appium::Console::VERSION
    DATE = '2026-10-28' unless defined? ::Appium::Console::DATE # x-release-please-date
  end
end
