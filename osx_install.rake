# For OS X, installs all the dependencies for Appium's ruby console, per these instructions:
#
# https://github.com/appium/ruby_console/blob/master/osx.md
#
# Changes to this file might imply changes to those instructions as well.

def sh_success(cmd)
  success = false
  begin
    success, status = sh cmd
  rescue
    # do nothing  
  end
  
  success
end
  
def has_cmd(cmd)
  sh_success "which #{cmd}"
end

THIS_DIR     = File.expand_path(File.dirname(__FILE__))
APPIUM_DIR = "#{THIS_DIR}/appium"
  
GCC = '/usr/bin/gcc'
GCC42_CMD = 'gcc-4.2'
GCC42 = "/usr/local/bin/#{GCC42_CMD}"

file GCC do
	fail "#{GCC} does not exist. This is likely because you do not have Xcode command line tools installed."
end

file GCC42 => [GCC] do
  sh "ln -s #{GCC} #{GCC42}"
end

task :gcc do
  if !has_cmd('gcc-4.2') then
    Rake::Task[GCC42].invoke
  end
end
    
task :java do
  if !has_cmd('java') then
    puts "You must install java to continue."
    puts "cf. http://www.oracle.com/technetwork/java/javase/downloads/index.html"
  end
end

task :ruby => [:gcc] do
  if has_cmd('rvm') then
    # doesn't hurt anything if already installed
    sh 'rvm install 2.0.0'
  else
    sh '\curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0'
  end
  
  system '/bin/bash --login -i -c "rvm use --default 2.0.0"'
  sh 'rvm osx-ssl-certs update all'
end

task :gems => [:ruby] do
  sh 'gem update --system'
  sh 'gem install --no-rdoc --no-ri bundler'
  sh 'gem update'
  sh 'gem cleanup'
  sh 'gem uninstall -aIx appium_lib'
  sh 'gem uninstall -aIx appium_console'
  sh 'gem install --no-rdoc --no-ri appium_console'
  sh 'gem uninstall -aIx flaky'
  sh 'gem install --no-rdoc --no-ri flaky'
end

task :brew do
  if has_cmd('brew') then
    sh 'brew update'
  else
    sh 'ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"'
  end
end

task :ant do
  if !has_cmd('ant') then
    fail "Ant must be installed to complete this setup."
  end
end

task :maven do
  if !has_cmd('mvn') then
    Rake::Task[:brew].invoke    
    sh 'brew install maven'
  end
end

task :nodejs => [:brew] do
  sh 'brew install node' # noop if already installed
  if sh_success 'brew outdated | grep node' then
    sh 'brew upgrade node'
  end if

  # make sure it's installed
  sh 'node --version' 
  sh 'npm --version'
end

task :grunt => [:nodejs] do
  if !sh_success('grunt --version') then
    sh 'npm install -g grunt grunt-cli'
    sh 'grunt --version'
  end
end

# we only clone when the directory doesn't already exist
directory APPIUM_DIR do
  cd THIS_DIR
  sh 'git clone git://github.com/appium/appium.git'
end

# appium goes into the directory below where this Rakefile is
desc 'Downloads appium and all dependencies, and starts up appium. May require a superuser password.'
task :appium => [APPIUM_DIR, :grunt, :maven, :ant, :gems, :ruby, :java] do
  cd APPIUM_DIR
  sh 'git pull origin master'
  sh './reset.sh'

  begin
    sh 'sudo `which grunt` authorize'
  rescue
    # grunt errors if it has already been authorized, so ... I guess we'll ignore errors then
  end

  sh 'node server.js'
end

task :default => :appium  
