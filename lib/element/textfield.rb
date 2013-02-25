# encoding: utf-8
# UIATextField methods

# Get an array of textfield values.
# @return [Array<String>]
def textfields
  find_eles_attr :textfield, :value
end

# Get an array of textfield elements.
# @return [Array<Textfield>]
def e_textfields
  find_eles :textfield
end

# Get the first textfield element.
# @return [Textfield]
def first_textfield
  first_ele :textfield
end

# Get the last textfield element.
# @return [Textfield]
def last_textfield
  last_ele :textfield
end

# Get the first textfield that matches value.
# @param value [String] the value to match exactly
# @return [Textfield]
def textfield value
  find_ele_by_value :textfield, value
end

# Get the first textfield that includes value.
# @param value [String] the value the textfield must include
# @return [Textfield]
def textfield_include value
  find_ele_by_value_include :textfield, value
end