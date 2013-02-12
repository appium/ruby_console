class Selenium::WebDriver::Element
  
  # NoMethodError: undefined method `name' for #<Selenium::WebDriver::Element
  def name
    self.attribute :name
  end
  
  # NoMethodError: undefined method `type' for #<Selenium::WebDriver::Element
  def type
    self.attribute :type
  end
  
  # Tag name appears to be the same as type.
  # Selenium::WebDriver::Error::UnknownError: Not yet implemented
  def tag_name
    type
  end

  # For use with mobile tap.
  # @driver.execute_script 'mobile: tap', :x => 0.0, :y => 0.98
  # https://github.com/appium/appium/wiki/Automating-mobile-gestures
  def location_rel
    xy = self.location
    w = window_size
    OpenStruct.new( :x => xy.x.to_f / w.width.to_f,
                    :y => xy.y.to_f / w.height.to_f )
  end
end

# Print JSON posted to Appium
# Requires from lib/selenium/webdriver/remote.rb
require 'selenium/webdriver/remote/capabilities'
require 'selenium/webdriver/remote/bridge'
require 'selenium/webdriver/remote/server_error'
require 'selenium/webdriver/remote/response'
require 'selenium/webdriver/remote/commands'
require 'selenium/webdriver/remote/http/common'
require 'selenium/webdriver/remote/http/default'

module Selenium::WebDriver::Remote
  class Bridge
    # Code from lib/selenium/webdriver/remote/bridge.rb
    def raw_execute(command, opts = {}, command_hash = nil)
      verb, path = COMMANDS[command] || raise(ArgumentError, "unknown command: #{command.inspect}")
      path       = path.dup
      
      path[':session_id'] = @session_id if path.include?(":session_id")
      
      begin
        opts.each { |key, value| path[key.inspect] = escaper.escape(value.to_s) }
        rescue IndexError
        raise ArgumentError, "#{opts.inspect} invalid for #{command.inspect}"
      end
      
      puts verb
      puts path
      puts command_hash.to_json
      
      puts "-> #{verb.to_s.upcase} #{path}" if $DEBUG
      http.call verb, path, command_hash
    end # def
  end # class
end # module