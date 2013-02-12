# encoding: utf-8
# UIAWindow methods
# http://developer.apple.com/library/ios/#documentation/ToolsLanguages/Reference/UIAWindowClassReference/UIAWindow/UIAWindow.html#//apple_ref/doc/uid/TP40009930

# @driver.manage.window.size is not yet implemented
# so invoke UI Automation directly.
# https://github.com/appium/appium/issues/157
def window_size
  # Always use top level @driver instance var because
  # it's called in patch.rb from webdriver scope.
  driver = TOPLEVEL_BINDING.eval '@driver'
  return nil if driver.nil?
  size = driver.execute_script "UIATarget.localTarget().frontMostApp().mainWindow().rect()"
  return nil if size.nil?
  size = size['size']
  OpenStruct.new :width => size['width'], :height => size['height']
end