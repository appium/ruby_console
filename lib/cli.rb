# frozen_string_literal: true

require 'rubygems'
require 'thor'
require 'appium_console/version'
require 'appium_lib/version'
require 'erb'
require 'appium_console'

module Appium::CLI # rubocop:disable Style/ClassAndModuleChildren
  module Config
    class << self
      def default_appium_txt_path
        'appium.txt'
      end

      def template(caps)
        <<-TEMPLATE.gsub(/skip\s/, '')
[caps]
platformName = "#{caps[:platform_name]}"
automationName = "#{caps[:automation_name]}"
#{caps[:platform_version] ? "platformVersion = \"#{caps[:platform_version]}\"" : 'skip'}
#{caps[:device_name] ? "deviceName = \"#{caps[:device_name]}\"" : 'skip'}
app = "#{caps[:path_to_app]}"
#{caps[:app_package] ? "appPackage = \"#{caps[:app_package]}\"" : 'skip'}
#{caps[:app_activity] ? "appActivity = \"#{caps[:app_activity]}\"" : 'skip'}

[appium_lib]
server_url = "http://127.0.0.1:4723/"
        TEMPLATE
      end
    end
  end

  class Setup < Thor
    desc 'ios', 'Generates toml for ios'
    method_option :force, type: :boolean, default: false, desc: 'Overwrite an existing appium.txt'
    def ios
      toml = File.join(Dir.pwd, Config.default_appium_txt_path)
      template = Config.template(
        automation_name: 'XCUITest',
        platform_name: 'iOS',
        device_name: 'iPhone Simulator',
        platform_version: '15.0',
        path_to_app: '/path/to/app_bundle'
      )
      write_config(toml, template)
    end

    desc 'android', 'Generates toml for android'
    method_option :force, type: :boolean, default: false, desc: 'Overwrite an existing appium.txt'
    def android
      toml = File.join(Dir.pwd, Config.default_appium_txt_path)
      template = Config.template(
        automation_name: 'uiautomator2',
        platform_name: 'Android',
        device_name: 'Pixel 5',
        path_to_app: '/path/to/apk',
        app_package: 'com.package.example',
        app_activity: 'com.package.example.ExampleActivity'
      )
      write_config(toml, template)
    end

    private

    def write_config(path, template)
      File.write(path, template, mode: options[:force] ? 'w' : 'wx')
    rescue Errno::EEXIST
      raise Thor::Error, "#{path} already exists. Use --force to overwrite it."
    end
  end

  class Main < Thor
    def self.exit_on_failure?
      true
    end

    desc 'version', 'Prints version of appium_lib and appium_console'
    def version
      puts <<-VERSION
appium_console: v#{::Appium::Console::VERSION}
    appium_lib: v#{::Appium::VERSION}
      VERSION
    end

    desc 'toml [FILE]', 'Starts appium console session with path to toml file'
    def toml(appium_txt_path = Config.default_appium_txt_path)
      Appium::Console.setup appium_txt_path
      Appium::Console.start
    end

    desc 'init', 'Starts appium console session with defaults settings'
    def init
      Appium::Console.setup Config.default_appium_txt_path
      Appium::Console.start
    end
    default_command :init

    desc 'setup', 'Generates toml file'
    subcommand 'setup', Setup
  end
end

Appium::CLI::Main.start(ARGV)
