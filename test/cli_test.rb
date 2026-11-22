# frozen_string_literal: true

require 'minitest/autorun'
require 'open3'
require 'tmpdir'
require 'tomlrb'

class CliTest < Minitest::Test
  ROOT = File.expand_path('..', __dir__)

  def run_arc(*args, offline: false, **options)
    preload = offline ? ['-r', File.join(__dir__, 'support/offline_session')] : []
    Open3.capture3(Gem.ruby, *preload, '-I', File.join(ROOT, 'lib'), File.join(ROOT, 'bin/arc'), *args, **options)
  end

  def test_configured_console_exposes_global_and_bare_methods
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, 'appium.txt'), <<~TOML)
        [caps]
        platformName = "iOS"
        automationName = "XCUITest"
      TOML
      input = 'puts [get_source, $driver.get_source, Object.new.get_source].join("/")'
      stdout, stderr, status = run_arc(stdin_data: input, chdir: dir, offline: true)
      assert status.success?, stderr
      assert_includes stdout, "ios/ios/ios\n"
      assert_includes stdout, "closed ios\n"
    end
  end

  def test_multi_sessions_can_be_used_and_closed_independently
    Dir.mktmpdir do |dir|
      input = <<~RUBY
        ios = Appium::Driver.new({ caps: { platformName: 'iOS', automationName: 'XCUITest' } }, false)
        android = Appium::Driver.new({ caps: { platformName: 'Android', automationName: 'UiAutomator2' } }, false)
        ios.start_driver
        android.start_driver
        puts [ios.get_source, android.get_source, $driver.nil?, respond_to?(:get_source, true)].join("/")
        ios.driver_quit
        puts "remaining " + android.get_source
        android.driver_quit
      RUBY
      stdout, stderr, status = run_arc('multi', stdin_data: input, chdir: dir, offline: true)
      assert status.success?, stderr
      assert_includes stdout, "ios/android/true/false\n"
      assert_includes stdout, "remaining android\n"
      assert_includes stdout, "closed android\n"
    end
  end

  def test_setup_generates_driver_and_server_settings
    { 'ios' => 'XCUITest', 'android' => 'uiautomator2' }.each do |platform, driver|
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          _, stderr, status = run_arc('setup', platform)
          assert status.success?, stderr
          config = Tomlrb.load_file('appium.txt')
          assert_equal driver, config.fetch('caps').fetch('automationName')
          assert_equal platform == 'ios' ? 'iOS' : 'Android', config.fetch('caps').fetch('platformName')
          assert_equal 'http://127.0.0.1:4723/', config.fetch('appium_lib').fetch('server_url')
        end
      end
    end
  end

  def test_setup_preserves_existing_config_unless_forced
    %w[ios android].each do |platform|
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          File.write('appium.txt', 'custom configuration')
          _, stderr, status = run_arc('setup', platform)
          refute status.success?
          assert_includes stderr, '--force'
          assert_equal 'custom configuration', File.read('appium.txt')

          _, stderr, status = run_arc('setup', platform, '--force')
          assert status.success?, stderr
          assert Tomlrb.load_file('appium.txt').fetch('caps').key?('automationName')
        end
      end
    end
  end

  def test_version_command
    stdout, stderr, status = run_arc('version')
    assert status.success?, stderr
    assert_includes stdout, 'appium_console:'
    assert_includes stdout, 'appium_lib:'
  end
end
