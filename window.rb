# encoding: utf-8
# UIAWindow methods
# http://developer.apple.com/library/ios/#documentation/ToolsLanguages/Reference/UIAWindowClassReference/UIAWindow/UIAWindow.html#//apple_ref/doc/uid/TP40009930

# @driver.manage.window.size is not yet implemented
# so invoke UI Automation directly.
# https://github.com/appium/appium/issues/157
def window_size
  size = @driver.execute_script "UIATarget.localTarget().frontMostApp().mainWindow().rect()"
  size = size['size'] unless size.nil?
end