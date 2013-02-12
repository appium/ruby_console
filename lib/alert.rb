# encoding: utf-8

# value is either an integer index of the button or the button name.
def alert_click value
  @driver.execute_script "UIATarget.localTarget().frontMostApp().alert().buttons()[#{value}].tap();"
end