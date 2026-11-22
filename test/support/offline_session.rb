# frozen_string_literal: true

require 'appium_lib'

# Exercise the real appium_lib wrappers and console startup without a server.
module OfflineSession
  Session = Struct.new(:page_source) do
    def quit
      puts "closed #{page_source}"
    end
  end

  def start_driver(**)
    Session.new(device.to_s)
  end

  def appium_server_version
    {}
  end
end

Appium::Core::Driver.prepend(OfflineSession)
