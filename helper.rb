# encoding: utf-8
# Generic helper methods not specific
# to a particular tag name

# json and ap are required for the source method.
require 'json'
require 'ap' # awesome print

# Returns elements matching the tag name
def find_tags tag_name
  @driver.find_elements :tag_name, tag_name
end

# Returns an array of attribute values from elements matching the tag name.
def find_tags_attr tag_name, attribute
  results = []
  elements = @driver.find_elements :tag_name, tag_name
  elements.each { |e| results.push e.attribute(attribute) }
  results
end

# Find element by name. Works with buttons.
def find_name name
  @driver.find_element :name, name
end

# Searches all tags and returns the first that
# matches value.
# Alternative to value search is finding all tags of type
# and then selecting one by index.
def find_tag_by_value tag, value
  result = nil
  
  find_tags(tag).each do |found|
    if found.attribute(:value) == value
      result = found
      break
    end
  end
  
  result
end

# Returns first tag that matches tag_name
def first_tag tag_name
  tag = find_tags tag_name
  tag = tag.first unless tag.nil?
end

# Prints a JSON view of the current page
def source
  ap JSON.parse(@driver.page_source)
end

# Password character returned from value of UIASecureTextField
def password length=1
  '•' * length
end