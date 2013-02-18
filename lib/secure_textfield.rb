# encoding: utf-8
# UIASecureTextField methods

# Returns an array of secure textfield values.
def secure_textfields
  find_tags_attr :secure, :value
end

# Returns an array of secure textfield elements.
def e_secure_textfields
  find_tags :secure
end

# Returns the first secure textfield element.
def first_secure_textfield
  first_tag :secure
end

# Returns the last secure textfield element.
def last_secure_textfield
  last_tag :secure
end

# Returns the first secure textfield that matches value.
def secure_textfield value
  find_tag_by_value :secure, value
end

# Returns the first secure textfield that includes value.
def secure_textfield_include value
  find_tag_by_value_include :secure, value
end