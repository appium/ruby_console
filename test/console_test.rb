# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require 'open3'
require 'tmpdir'
require 'appium_console'

class ConsoleTest < Minitest::Test
  def test_start_requires_files_with_special_characters_literally
    Dir.mktmpdir do |dir|
      file = File.join(dir, 'page"\\#{raise "interpolated"}.rb')
      File.write(file, 'puts "page loaded"')
      parsed = { appium_lib: { require: [file] } }
      Appium::Console.setup('appium.txt')
      launch = lambda do |args|
        assert_equal '-r', args.first
        assert_equal File.expand_path('../lib/start.rb', __dir__), args[1]
        assert_equal '-e', args[2]
        stdout, stderr, status = Open3.capture3(Gem.ruby, '-e', args[3])
        assert status.success?, stderr
        assert_equal "page loaded\n", stdout
      end
      Appium.stub(:load_appium_txt, parsed) do
        Pry::CLI.stub(:parse_options, ->(args) { args }) do
          Pry::CLI.stub(:start, launch) { capture_io { Appium::Console.start } }
        end
      end
    ensure
      Pry.hooks.delete_hook(:after_session, 'Release session hook')
    end
  end

  def test_reload_loads_changed_file_contents
    Dir.mktmpdir do |dir|
      file = File.join(dir, 'page.rb')
      Appium::Console.setup('appium.txt')
      Appium.stub(:load_appium_txt, { appium_lib: { require: [file] } }) do
        File.write(file, 'puts "first version"')
        assert_output("first version\n") { Pry.reload }
        File.write(file, 'puts "second version"')
        assert_output("second version\n") { Pry.reload }
      end
    end
  end
end
