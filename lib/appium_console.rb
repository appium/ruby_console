require 'rubygems'
require 'pry'
require 'appium_lib'

# Silence gem warnings
Gem::Specification.class_eval do
  def self.warn(args); end
end

module Appium
  module Console
    class << self
      def setup(appium_txt_path)
        Pry.send(:define_singleton_method, :pry_load_appium_txt) do |opts = {}|
          verbose = opts.fetch :verbose, false
          path = appium_txt_path
          Appium.load_appium_txt file: path, verbose: verbose
        end

        Pry.send(:define_singleton_method, :reload) do
          parsed = Pry.pry_load_appium_txt
          return unless parsed && parsed[:appium_lib] && parsed[:appium_lib][:require]

          requires = parsed[:appium_lib][:require]
          requires.each do |file|
            # If a page obj is deleted then load will error.
            begin
              load file
            rescue LoadError => e
              puts e.message
            end
          end
        end
      end

      def start
        start = File.expand_path 'start.rb', __dir__
        cmd = ['-r', start]

        parsed = Pry.pry_load_appium_txt verbose: true
        has_requires = parsed && parsed[:appium_lib] && parsed[:appium_lib][:require]
        if has_requires
          requires = parsed[:appium_lib][:require]

          unless requires.empty?
            load_files = requires.map { |f| %(require "#{f}";) }.join "\n"
            cmd += ['-e', load_files]
          end

          $stdout.puts "pry #{cmd.join(' ')}"
        end

        Pry.hooks.add_hook(:after_session, 'Release session hook') do |output, _binding, _pry|
          output.puts 'Closing appium session...'
          $driver.x
        end

        opts = Pry::CLI.parse_options cmd
        Pry::CLI.start(opts)
      end
    end
  end
end
