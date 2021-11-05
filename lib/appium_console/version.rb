# frozen_string_literal: true

# Define Appium module so version can be required directly.
module Appium; end unless defined? Appium
module Appium
  module Console
    VERSION = '2.14.0.rc2' unless defined? ::Appium::Console::VERSION
    DATE = '2021-11-05' unless defined? ::Appium::Console::DATE
  end
end
