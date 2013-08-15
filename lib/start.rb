# encoding: utf-8
require 'rubygems'
require 'appium_lib'

Appium::Driver.new(export_session: true).start_driver if $driver.nil?