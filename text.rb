# encoding: utf-8
# UIAStaticText methods

# Returns an array of text names.
def texts
  find_tags_attr :text, :name
end

# Returns an array of text elements.
def e_texts
  find_tags :text
end

# Returns the first text element.
def first_text
  first_tag :text
end

# Returns the first element that matches name.
def find_text name
  find_name name
end

# Returns the first textfield that includes name.
def find_text_include name
  find_tag_by_name_include :text, name
end