# encoding: utf-8
# UIAButton methods

# Returns an array of button names.
def buttons
  find_tags_attr :button, :name
end

# Returns an array of buttons elements.
def e_buttons
  find_tags :button
end

# TODO: Rewrite once this bug is fixed.
# https://github.com/appium/appium/issues/163
#
# Returns the button element matching name and
# occurrence. number=2 means the 2nd occurrence.
#
# find the 2nd Sign In button
# b = e_button 'Sign In', 2
#
# name = exact name of the button to match
# number 1 = first button
def e_button name, number
  raise "Number must be >= 1" if number <= 0
  number = number - 1 # zero indexed

  all = find_tags :button
  result = nil
  count = 0

  all.each do |btn|
    if btn.name == name
      if count == number
        result = btn
        break
      end
      count = count + 1
    end # if name
  end # each

  result
end

# Returns the first button element.
def first_button
  first_tag :button
end

# Returns the first element that matches name.
def button name
  find_name name
end

# Returns the first button that includes name.
def button_include name
  find_tag_by_name_include :button, name
end