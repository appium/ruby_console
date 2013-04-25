# encoding: utf-8
require 'rubygems'
require 'appium_lib'

Appium::Driver.new.start_driver if $last_driver.nil?