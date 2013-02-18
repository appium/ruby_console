# encoding: utf-8
# Generic helper methods not specific
# to a particular tag name

# json and ap are required for the source method.
require 'json'
require 'ap' # awesome print
require 'timeout' # for wait

def wait &w
  # Give up after 30 seconds.
  # Check every 0.5 seconds to see if w.call is true
  # Timeout::Error: execution expired
  r = nil
  timeout(30) { while(!(r=w.call)) do; sleep(0.5) end }
  r#esult
end

# Returns elements matching the tag name
def find_tags tag_name
  $driver.find_elements :tag_name, tag_name
end

# Returns an array of attribute values from elements matching the tag name.
# This is slow because one call is made per attribute.
# See https://github.com/appium/appium/issues/169
def find_tags_attr tag_name, attribute
  results = []
  elements = $driver.find_elements :tag_name, tag_name
  elements.each { |e| results.push e.attribute(attribute) }
  results
end

# Find first element by name. Works with button and text.
# nil is returned if the element is not found.
# nil is also returned when $driver times out.
def find_name name
  begin
    result = $driver.find_element :name, name
  # rescue Selenium::WebDriver::Error::NoSuchElementError
  rescue; end
end

# Find all elements by name.
def find_names name
  begin
    result = $driver.find_elements :name, name
    # rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue; end
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

# tag   - the tag name to search for
# attr  - the attribute to compare against
# value - the value being searched for
def find_tag_by_attr_include tag, attr, value
  result = nil
  
  find_tags(tag).each do |found|
    # value may return a Fixnum
    if found.attribute(attr).to_s.include? value
      result = found
      break
    end
  end
  
  result
end

# element.attribute(:value).include? value
def find_tag_by_value_include tag, value
  find_tag_by_attr_include tag, :value, value
end

# element.attribute(:name).include? value
def find_tag_by_name_include tag, value
  find_tag_by_attr_include tag, :name, value
end

# Returns first tag that matches tag_name
def first_tag tag_name
  tag = find_tags tag_name
  tag = tag.first unless tag.nil?
end

# Returns last tag that matches tag_name
def last_tag tag_name
  tag = find_tags tag_name
  tag = tag.last unless tag.nil?
end

# Prints a JSON view of the current page
def source
  ap JSON.parse($driver.page_source)
end

# Password character returned from value of UIASecureTextField
def password length=1
  '•' * length
end