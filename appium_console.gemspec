# encoding: utf-8
def self.add_to_path path
 path = File.expand_path "../#{path}/", __FILE__

 $:.unshift path unless $:.include? path
end

add_to_path 'lib'

require 'appium_console/version'

Gem::Specification.new do |s|
  # 1.8.x is not supported
  s.required_ruby_version = '>= 1.9.3'

  s.name = 'appium_console'
  s.version = Appium::Console::VERSION
  s.date = Appium::Console::DATE
  s.license = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description = s.summary = 'Appium Ruby Console'
  s.description += '.' # avoid identical warning
  s.authors = s.email = [ 'code@bootstraponline.com' ]
  s.homepage = 'https://github.com/appium/ruby_console' # published as appium_console
  s.require_paths = [ 'lib' ]

  # appium_lib version must match ruby console version.
  s.add_runtime_dependency 'appium_lib', '>= 1.0.0'
  s.add_runtime_dependency 'pry', '~> 0.9.12.5'
  s.add_runtime_dependency 'bond', '~> 0.5.0'
  s.add_runtime_dependency 'spec', '>= 5.3.3'
  s.add_development_dependency 'rake', '~> 10.1.0'
  s.add_development_dependency 'posix-spawn', '~> 0.3.8'

  s.executables   = [ 'arc' ]
  s.files = `git ls-files`.split "\n"
end
