# encoding: utf-8

def self.add_to_path path
 path = File.expand_path "../#{path}/", __FILE__

 $:.unshift path unless $:.include? path
end

add_to_path 'lib'

require 'ruby_console/version'

Gem::Specification.new do |s|
  # 1.8.x is not supported
  s.required_ruby_version = '>= 1.9.3'

  s.name = 'ruby_console'
  s.version = RubyConsole::VERSION
  s.date = RubyConsole::DATE
  s.license = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description = s.summary = 'Ruby console for use with Appium'
  s.description += '.' # avoid identical warning
  s.authors = s.email = [ 'code@bootstraponline.com' ]
  s.homepage = 'https://github.com/appium/ruby_console'
  s.require_paths = [ 'lib' ]

  s.add_runtime_dependency 'app_lib', '>= 0.0.12'
  s.add_runtime_dependency 'pry', '~> 0.9.12'
  
  # Why are these required?
  # WARN: Unresolved specs during Gem::Specification.reset:
  #    multi_json (~> 1.0)
  #    ffi (>= 1.0.6, ~> 1.0)
  s.add_runtime_dependency 'multi_json', '~> 1.7.1'
  s.add_runtime_dependency 'ffi', '~> 1.4.0'

  s.add_development_dependency 'rake', '~> 10.0.3'

  s.executables   = [ 'arc' ]
  s.files = `git ls-files`.split "\n"
end