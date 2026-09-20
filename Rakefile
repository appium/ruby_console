require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
end

desc('Execute RuboCop static code analysis')
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w(lib test)
  t.options = %w(-D)
  t.fail_on_error = true
end
