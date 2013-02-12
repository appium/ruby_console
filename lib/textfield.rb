# encoding: utf-8
# UIATextField methods

# Returns an array of textfield values.
def textfields
  find_tags_attr :textfield, :value
end

# Returns an array of textfield elements.
def e_textfields
  find_tags :textfield
end

# Returns the first textfield element.
def first_textfield
  first_tag :textfield
end

# Returns the first textfield that matches value.
def textfield value
  find_tag_by_value :textfield, value
end

# Returns the first textfield that includes value.
def textfield_include value
  find_tag_by_value_include :textfield, value
end