# encoding: utf-8
# UIASecureTextField methods

# Get an array of secure textfield texts.
# @return [Array<String>]
def secures
  find_eles_attr :secure, :text
end

# Get an array of secure textfield elements.
# @return [Array<Secure>]
def e_secures
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

# Get the first secure textfield that matches text.
# @param text [String] the text to find exactly
# @return [Secure]
def secure text
  find_ele_by_text :secure, text
end

# Get the first secure textfield that includes text.
# @param text [String] the text that the tag must include
# @return [Secure]
def secure_include text
  find_ele_by_text_include :secure, text
end
