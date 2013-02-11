# encoding: utf-8
# UIASecureTextField methods

# Returns an array of secure textfield values.
def secure_textfields
  find_tags_attr :UIASecureTextField, :value
end

# Returns an array of secure textfield elements.
def e_secure_textfields
  find_tags :UIASecureTextField
end

# Returns the first secure textfield element.
def first_secure_textfield
  first_tag :UIASecureTextField
end

# Returns the first secure textfield that matches value.
def find_secure_textfield value
  find_tag_by_value :UIASecureTextField, value
end

# Returns the first UIASecureTextField that includes value.
def find_secure_textfield_include value
  find_tag_by_value_include :UIASecureTextField, value
end