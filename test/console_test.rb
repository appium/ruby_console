# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require 'tmpdir'
require 'appium_console'

class ConsoleTest < Minitest::Test
  def test_session_exposes_driver_and_loads_and_reloads_files_literally
    Dir.mktmpdir do |dir|
      file = File.join(dir, 'page"\#{raise "interpolated"}.rb')
      File.write(file, 'puts "first version"')
      opts = { appium_lib: { require: [file] } }
      driver = Minitest::Mock.new
      driver.expect(:start_driver, nil)
      driver.expect(:get_source, '<app/>')
      driver.expect(:driver_quit, nil)
      launch = lambda do |session|
        assert_equal '<app/>', session.driver.get_source
        refute Object.method_defined?(:get_source)
        File.write(file, 'puts "second version"')
        session.reload
      end
      build = driver_factory(driver, opts.merge(caps: { newCommandTimeout: 999_999 }))
      Appium.stub(:load_appium_txt, opts) do
        Appium::Driver.stub(:new, build) do
          Pry.stub(:start, launch) do
            assert_output("first version\nsecond version\nClosing appium session...\n") do
              Appium::Console::Session.new('appium.txt').start
            end
          end
        end
      end
      driver.verify
    end
  end

  def test_session_releases_its_driver_when_the_console_raises
    driver = Minitest::Mock.new
    driver.expect(:start_driver, nil)
    driver.expect(:driver_quit, nil)
    config = { caps: { 'appium:newCommandTimeout': 90 } }
    build = driver_factory(driver, config)
    Appium.stub(:load_appium_txt, config) do
      Appium::Driver.stub(:new, build) do
        Pry.stub(:start, ->(_) { raise IOError }) do
          assert_output("Closing appium session...\n") do
            assert_raises(IOError) { Appium::Console::Session.new('appium.txt').start }
          end
        end
      end
    end
    driver.verify
  end

  private

  def driver_factory(driver, expected_config)
    lambda do |config, global|
      refute global
      assert_equal expected_config, config
      driver
    end
  end
end
