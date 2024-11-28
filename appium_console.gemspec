# encoding: utf-8
def self.add_to_path path
 path = File.expand_path "../#{path}/", __FILE__

 $:.unshift path unless $:.include? path
end

add_to_path 'lib'

require 'appium_console/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 3.0'

  s.name          = 'appium_console'
  s.version       = Appium::Console::VERSION
  s.date          = Appium::Console::DATE
  s.license       = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description   = s.summary = 'Appium Ruby Console'
  s.description   += '.' # avoid identical warning
  s.authors       = ['code@bootstraponline.com', 'Kazuaki Matsuo']
  s.email         = %w(code@bootstraponline.com fly.49.89.over@gmail.com)
  s.homepage      = 'https://github.com/appium/ruby_console' # published as appium_console
  s.require_paths = [ 'lib' ]

  # appium_lib version must match ruby console version.
  s.add_runtime_dependency 'appium_lib', '>= 14.0.0'
  s.add_runtime_dependency 'pry', '~> 0.14.0'
  s.add_runtime_dependency 'thor', '>= 0.19', '< 2.0'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'appium_thor', '~> 2.0'
  s.add_development_dependency 'rubocop', '1.69.0'

  s.executables   = [ 'arc' ]
  s.files = `git ls-files`.split "\n"
end
