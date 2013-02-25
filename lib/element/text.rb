# encoding: utf-8
# UIAStaticText methods

# Get an array of text names.
# @return [Array<String>]
def texts
  find_eles_attr :text, :name
end

# Get an array of text elements.
# @return [Array<Text>]
def e_texts
  find_eles :text
end

# Get the first text element.
# @return [Text]
def first_text
  first_ele :text
end

# Get the last text element
# @return [Text]
def last_text
  last_ele :text
end

# Get the first element that matches name.
# @param value [String] the name to find exactly
# @return [Text]
def text name
  find_ele_by_name :text, name
end

# Get the first textfield that includes name.
# @param value [String] the name that the tag must include
# @return [Text]
def text_include name
  find_ele_by_name_include :text, name
end