# encoding: utf-8
# UIASecureTextField methods

# Get an array of secure textfield values.
# @return [Array<String>]
def secures
  find_eles_attr :secure, :value
end

# Get an array of secure textfield elements.
# @return [Array<Secure>]
def e_secure
  find_eles :secure
end

# Get the first secure textfield element.
# @return [Secure]
def first_secure
  first_ele :secure
end

# Get the last secure textfield element.
# @return [Secure]
def last_secure
  last_ele :secure
end

# Get the first secure textfield that matches value.
# @param value [String] the value to find exactly
# @return [Secure]
def secure value
  find_ele_by_value :secure, value
end

# Get the first secure textfield that includes value.
# @param value [String] the value that the tag must include
# @return [Secure]
def secure_include value
  find_ele_by_value_include :secure, value
end