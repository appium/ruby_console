require 'appium_thor'

Appium::Thor::Config.set do
  gem_name     'appium_console'
  github_owner 'appium'
  github_name  'ruby_console'
  version_file 'lib/appium_console/version.rb'
end

# Must use '::' otherwise Default will point to Thor::Sandbox::Default
# Debug by calling Thor::Base.subclass_files via Pry
#
# https://github.com/erikhuda/thor/issues/484
#
class ::Default < Thor
  desc 'spec', 'Run RSpec tests'
  def spec
    exec 'rspec spec'
  end
end
