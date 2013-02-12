# encoding: utf-8

# value is either an integer index of the button or the button name.
def alert_click value
  @driver.execute_script "UIATarget.localTarget().frontMostApp().alert().buttons()[#{value}].tap();"
end

# Returns the alert message text.
def alert_text
  @driver.switch_to.alert.text
end

# Accepts the alert.
def alert_accept
  @driver.switch_to.alert.accept
end

# Returns the text of the alert accept button.
# last button = accept
def alert_accept_text
  a = @driver.find_element(:tag_name, :alert)
  return if a.nil?
  b = a.find_elements(:tag_name, :button)
  b.last.text if b.size >= 1
end

# Dismisses the alert.
def alert_dismiss
  @driver.switch_to.alert.dismiss
end

# Returns the text of the alert dismiss button.
# first button = dismiss
def alert_dismiss_text
  a = @driver.find_element(:tag_name, :alert)
  return if a.nil?
  b = a.find_elements(:tag_name, :button)
  b.first.text if b.size >= 1
end