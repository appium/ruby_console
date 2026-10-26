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
    class << self
      def setup(appium_txt_path)
        define_pry_method(:pry_load_appium_txt) do |opts = {}|
          verbose = opts.fetch :verbose, false
          path = appium_txt_path
          Appium.load_appium_txt file: path, verbose: verbose
        end

        define_pry_method(:reload) do
          parsed = Pry.pry_load_appium_txt
          requires = parsed&.dig(:appium_lib, :require)
          return unless requires

          requires.each do |file|
            # If a page obj is deleted then load will error.
            load file
          rescue LoadError => e
            puts e.message
          end
        end
      end

      def start
        start = File.expand_path 'start.rb', __dir__
        cmd = ['-r', start]

        parsed = Pry.pry_load_appium_txt verbose: true
        requires = parsed&.dig(:appium_lib, :require)
        if requires
          unless requires.empty?
            load_files = requires.map { |f| "require #{f.dump};" }.join "\n"
            cmd += ['-e', load_files]
          end

          $stdout.puts "pry #{cmd.join(' ')}"
        end

        register_release_session_hook

        opts = Pry::CLI.parse_options cmd
        Pry::CLI.start(opts)
      end

      private

      def define_pry_method(name, &)
        Pry.singleton_class.send(:remove_method, name) if Pry.respond_to?(name)
        Pry.send(:define_singleton_method, name, &)
      end

      def register_release_session_hook
        if Pry.hooks.hook_exists?(:after_session, 'Release session hook')
          Pry.hooks.delete_hook(:after_session, 'Release session hook')
        end
        Pry.hooks.add_hook(:after_session, 'Release session hook') do |output, _binding, _pry|
          output.puts 'Closing appium session...'
          x if respond_to?(:x, true)
        end
      end
    end
  end
end
