# encoding: utf-8
# UIAButton methods

=begin
 Method Signatures:

   button( name, number = -1 )
   buttons( name = nil )
   button_include( name )
   buttons_include( name )
   first_button
   last_button

 Examples:

   button 'name'    # 1st button exactly matching name
   button 'name', 2 # 2nd button exactly matching name

   buttons          # text of all buttons.
   buttons 'name'   # all buttons exactly matching name

   button_include  'name' # the first button that includes name
   buttons_include 'name' # all buttons that include name

   first_button     # the first button
   last_button      # the last button
=end

# Returns the first element that matches name.
# When number is set, that occurrence is found
# instead of the first element.
def button name, number=-1
  number >= 1 ? buttons_name( name, number ) :
  button_name( name )
end

# Returns an array of button names.
# If name is provided, return an array of button elements
# exactly matching name.
def buttons name=nil
  name == nil ? find_tags_attr(:button, :name) :
  $driver.find_elements(:xpath, "button[@name='#{name}']")
end

# Returns the first button that includes name.
def button_include name
  $driver.find_element :xpath, "button[contains(@name, '#{name}')]"
end

# Returns all buttons that include name.
def buttons_include name
  $driver.find_elements :xpath, "button[contains(@name, '#{name}')]"
end

# Returns the first button element.
def first_button
  first_tag :button
end

# Returns the last button element.
def last_button
  last_tag :button
end

# -- prefer above methods before using these.

# Finds the first button element that exactly matches name.
# Differs from 'find_name' in that this ensures the element
# is a button.
def button_name name
  $driver.find_element :xpath, "button[@name='#{name}']"
end

# Returns the button element exactly matching name and
# occurrence. number=2 means the 2nd occurrence.
#
# find the second Sign In button
# b = e_button 'Sign In', 2
#
# name = exact name of the button to match
# number 1 = first button
def buttons_name name, number
  raise "Number must be >= 1" if number <= 0
  number = number - 1 # zero indexed

  result = nil

  elements = $driver.find_elements :xpath, "button[@name='#{name}']"
  result = elements[number] if elements.size > number

  result
end

# Returns an array of buttons elements.
def e_buttons
  find_tags :button
end