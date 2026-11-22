# frozen_string_literal: true

require 'rubygems'
require 'pry'
require 'appium_lib'

# Silence gem warnings
Gem::Specification.class_eval do
  def self.warn(args); end
end

module Appium
  module Console
    class Session
      attr_reader :driver

      def initialize(config_path)
        @config_path = config_path
      end

      def start
        opts = Appium.load_appium_txt(file: @config_path, verbose: true)
        caps = opts[:caps] || {}
        unless caps.key?(:newCommandTimeout) || caps.key?(:'appium:newCommandTimeout')
          opts = opts.merge(caps: caps.merge(newCommandTimeout: 999_999))
        end

        @driver = Appium::Driver.new(opts, false)
        driver.start_driver
        configure_minitest
        Array(opts.dig(:appium_lib, :require)).each { |file| require file }
        Pry.config.command_prefix = '%'
        Pry.start(self)
      ensure
        if driver
          puts 'Closing appium session...'
          driver.driver_quit
        end
      end

      def reload
        opts = Appium.load_appium_txt(file: @config_path)
        Array(opts.dig(:appium_lib, :require)).each do |file|
          load file
        rescue LoadError => e
          puts e.message
        end
        nil
      end

      private

      def configure_minitest
        require 'minitest'
        require 'minitest/spec'
        Minitest::Spec.new 'pry'
      rescue StandardError => e
        puts e.message
      end
    end
  end
end
