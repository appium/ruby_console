# encoding: utf-8

require 'rubygems'
require 'appium_lib'

# gem install minitest minitest-reporters
require 'minitest/autorun'
# Format the report
require 'minitest/reporters'

# rename test, change end message.
# https://github.com/CapnKernul/minitest-reporters/blob/master/lib/minitest/reporters/progress_reporter.rb
module MiniTest
  module Reporters
    class ProgressReporter
      def error(suite, test, test_runner)
        test = test.to_s.sub(/test_\d+_/, '').to_sym
        wipe
        print(red { 'ERROR' })
        print_test_with_time(suite, test)
        puts
        print_info(test_runner.exception)
        puts

        self.color = RED
      end
      def after_suites(suites, type)
        @progress.close

        total_time = Time.now - runner.suites_start_time

        wipe
        puts
        puts('Finished in %.2fs' % total_time)
        tests = runner.test_count
        asserts = runner.assertion_count
        fails = runner.failures
        errors = runner.errors
        skips = runner.skips
        print("%d test#{tests == 1 ? '' : 's'}#{(asserts == fails && fails == errors && errors == skips && skips == 0) ? '' : ', '}" % [tests])
        print('%d assertions, ' % [runner.assertion_count]) unless asserts == 0
        print(red { '%d failures, ' } % [runner.failures]) unless fails == 0
        print(red { "%d error#{runner.errors == 1 ? '' : 's'}#{skips ? '' : ', '}" } % [errors]) unless errors == 0
        print(yellow { '%d skips' } % runner.skips) unless skips == 0
        puts
      end
    end
  end
end

MiniTest::Reporters.use! MiniTest::Reporters::ProgressReporter.new

# Alter '# Run options:' from minitest-reports
# https://github.com/CapnKernul/minitest-reporters/blob/master/lib/minitest/reporter_runner.rb#L28
module MiniTest
  class ReporterRunner < Unit
    def _run_suites(suites, type)
      test_order = @help.match /\-\-seed (\d+)/
      # '# Run options: --seed 10181' => 'test order: 10181'
      $stdout.puts "test order: #{test_order[1]}" if test_order
      @suites_start_time = Time.now
      count_tests!(suites, type)
      trigger_callback(:before_suites, suites, type)
      super(suites, type)
    ensure
      trigger_callback(:after_suites, suites, type)
    end
  end
end