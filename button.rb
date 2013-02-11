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

# Returns the first button element.
def first_button
  first_tag :button
end

# Returns the first element that matches name.
def find_button name
  find_name name
end

# Returns the first button that includes name.
def find_button_include name
  find_tag_by_name_include :button, name
end