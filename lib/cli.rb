require 'rubygems'
require 'thor'
require 'appium_console/version'
begin
  require 'appium_lib/common/version'
rescue LoadError
  require 'appium_lib/version'
end
require 'erb'
require 'appium_console'

module Appium::CLI
  module Config
    class << self
      def appium_txt_template_path
        File.join(File.dirname(__FILE__), "..", "templates/appium.txt.erb")
      end

      def default_appium_txt_path
        "appium.txt"
      end
    end
  end

  class Setup < Thor
    desc "ios", "Generates toml for ios"
    def ios
      toml     = File.join(Dir.pwd, Config.default_appium_txt_path)
      template = ERB.new(File.new(Config.appium_txt_template_path).read, nil, "-")
      File.open toml, 'w' do |f|
        caps = {
          automation_name: "XCUITest",
          platform_name: "iOS",
          device_name: "iPhone Simulator",
          platform_version: "10.3",
          path_to_app: "/path/to/app_bundle"
        }
        f.puts template.result(binding)
      end
    end

    desc "android", "Generates toml for android"
    def android
      toml     = File.join(Dir.pwd, Config.default_appium_txt_path)
      template = ERB.new(File.new(Config.appium_txt_template_path).read, nil, "-")
      File.open toml, 'w' do |f|
        caps = {
          automation_name: "uiautomator2",
          platform_name: "Android",
          device_name: "Nexus 5X",
          path_to_app: "/path/to/apk",
          app_package: "com.package.example",
          app_activity: ".ExampleActivity"
        }
        f.puts template.result(binding)
      end
    end
  end

  class Main < Thor
    desc "version", "Prints version of appium_lib and appium_console"
    def version
      puts "appium_console: v#{::Appium::Console::VERSION}"
      puts "    appium_lib: v#{::Appium::VERSION}"
      exit
    end

    desc "toml [FILE]", "Starts appium console session with path to toml file"
    def toml(appium_txt_path = Config.default_appium_txt_path)
      Appium::Console.setup appium_txt_path
      Appium::Console.start
    end

    desc "init", "Starts appium console session with defaults settings"
    def init
      Appium::Console.setup Config.default_appium_txt_path
      Appium::Console.start
    end
    default_command :init

    desc "setup", "Generates toml file"
    subcommand "setup", Setup
  end
end

Appium::CLI::Main.start(ARGV)
