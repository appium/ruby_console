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

# Find a button by name and optionally number.
# @param name [String] the name to exactly match
# @param number [Integer] the occurance of the button matching name. Defaults to the first button.
# @return [Button] the button found with name and matching number
def button name, number=0
  number >= 1 ? button_name_num( name, number ) :
  button_name( name )
end

# Get an array of button names or button elements if name is provided.
# @param name [String] the name to exactly match
# @return [Array<String>, Array<Buttons>] either an array of button names or an array of button elements if name is provided.
def buttons name=nil
  name == nil ? find_eles_attr(:button, :name) :
                find_ele_by_name(:button, name)
end

# Get the first button that includes name.
# @param name [String] the name that the element must include
# @return [Button]
def button_include name
  find_ele_by_name_include :button, name
end

# Get all buttons that include name.
# @param name [String] the name that the element must include
# @return [Array<Button>]
def buttons_include name
  find_eles_by_name_include :button, name
end

# Get the first button element.
# @return [Button]
def first_button
  first_ele :button
end

# Get the last button element.
# @return [Button]
def last_button
  last_ele :button
end

# -- prefer above methods before using these.

# Get the first button element that exactly matches name.
# @param name [String] the name to match exactly
# @return [Button]
def button_name name
  find_ele_by_name :button, name
end

# Get the button element exactly matching name and
# occurrence. number=2 means the 2nd occurrence.
#
# find the second Sign In button
#
# b = e_button 'Sign In', 2
#
# @param name [String] the name to match exactly
# @param number [Integer] the button occurance to return. 1 = first button
# @return [Button] the button that exactly matches name and number
def button_name_num name, number=1
  raise "Number must be >= 1" if number <= 0
  number = number - 1 # zero indexed

  result = nil

  elements = find_eles_by_name :button, name
  result = elements[number] if elements.size > number

  result
end

# Get an array of button elements.
# @return [Array<Button>]
def e_buttons
  find_eles :button
end
