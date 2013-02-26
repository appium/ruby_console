# encoding: utf-8
# Generic helper methods not specific
# to a particular tag name

# json and ap are required for the source method.
require 'json'
require 'ap' # awesome print
require 'timeout' # for wait

# Check every 0.5 seconds to see if block.call is true.
# Give up after 30 seconds.
# @param block [Block] the block to call
# @return [Object] the result of block.call
def wait &block
  # Rescue Timeout::Error: execution expired
  result = nil
  timeout(30) { while(!(result = begin;block.call;rescue;end)) do; sleep(0.5) end }
  result
end

# Get all elements exactly matching tag name
# @param tag_name [String] the tag name to find
# @return [Array<Element>] the found elements of type tag_name
def find_eles tag_name
  $driver.find_elements :tag_name, tag_name
end

# Get an array of attribute values from elements exactly matching tag name.
# @param tag_name [String] the tag name to find
# @param attribute [String] the attribute to collect
# @result [Array<String>] an array of strings containing the attribute from found elements of type tag_name.
def find_eles_attr tag_name, attribute
  js = %Q(
    var b = $('#{tag_name}');
    var r = [];
    for (var a = 0; a < b.length; a++) {
      r.push(b[a].#{attribute}());
    }
    r
  )

  $driver.execute_script js
end

# Find first element by name. Works with button and text.
# nil is returned if the element is not found.
# nil is also returned when $driver times out.
# Result can be ANY tag.
# @param name [String] the name to exactly match
# @return [Element] the first element exactly matching name
def find_name name
  begin
    result = $driver.find_element :name, name
  # rescue Selenium::WebDriver::Error::NoSuchElementError
  rescue; end
end

# Find all elements by name.
# Results can include ANY tag.
# @param name [String] the name to exactly match
# @return [Array<Element>] the elements exactly matching name
def find_names name
  begin
    result = $driver.find_elements :name, name
    # rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue; end
end

# Get the first tag that exactly matches value.
# tag name mapping:
# text field  = 'textfield'
# secure text field = 'secure'
# @param tag [String] the tag name to match
# @param value [String] the value to exactly match
# @return [Element] the element of type tag exactly matching value
def find_ele_by_value tag, value
  raise "Invalid tag #{tag}. Must be textfield or secure." \
  unless ['textfield', 'secure'].include? tag.to_s
  
  $driver.find_element :xpath, %Q(#{tag}[@value='#{value}'])
end

# Get the first tag that exactly matches tag and name.
# @param tag [String] the tag name to match
# @param name [String] the name to exactly match
# @return [Element] the element of type tag exactly matching name
def find_ele_by_name tag, name
  $driver.find_element :xpath, %Q(#{tag}[@name='#{name}'])
end

# Get all tags that exactly match tag and name.
# @param tag [String] the tag name to match
# @param name [String] the name to exactly match
# @return [Array<Element>] the elements of type tag exactly matching name
def find_eles_by_name tag, name
  $driver.find_elements :xpath, %Q(#{tag}[@name='#{name}'])
end

# Get the first tag by attribute that exactly matches value.
# @param tag [String] the tag name to match
# @param attr [String] the attribute to compare
# @param value [String] the value of the attribute that the element must include
# @return [Element] the element of type tag who's attribute includes value
def find_ele_by_attr_include tag, attr, value
  $driver.find_element :xpath, %Q(#{tag}[contains(@#{attr}, '#{value}')])
end

# Get tags by attribute that include value.
# @param tag [String] the tag name to match
# @param attr [String] the attribute to compare
# @param value [String] the value of the attribute that the element must include
# @return [Array<Element>] the elements of type tag who's attribute includes value
def find_eles_by_attr_include tag, attr, value
  $driver.find_elements :xpath, %Q(#{tag}[contains(@#{attr}, '#{value}')])
end

# Get the first tag that includes value.
# @param tag [String] the tag name to match
# @param value [String] the value the element must include
# @return [Element] the element of type tag that includes value
# element.attribute(:value).include? value
def find_ele_by_value_include tag, value
  find_ele_by_attr_include tag, :value, value
end

# Get the first tag that includes name.
# @param tag [String] the tag name to match
# @param name [String] the name the element must include
# @return [Element] the element of type tag that includes name
# element.attribute(:name).include? name
def find_ele_by_name_include tag, name
  find_ele_by_attr_include tag, :name, name
end

# Get the tags that include name.
# @param tag [String] the tag name to match
# @param name [String] the name the element must include
# @return [Array<Element>] the elements of type tag that includes name
# element.attribute(:name).include? name
def find_eles_by_name_include tag, name
  find_eles_by_attr_include tag, :name, name
end

# Get the first tag that matches tag_name
# @param tag_name [String] the tag to match
# @return [Element]
def first_ele tag_name
  tag = find_eles tag_name
  tag = tag.first unless tag.nil?
end

# Get the last tag that matches tag_name
# @param tag_name [String] the tag to match
# @return [Element]
def last_ele tag_name
  tag = find_eles tag_name
  tag = tag.last unless tag.nil?
end

# Prints a JSON view of the current page
# @return [void]
def source
  ap JSON.parse($driver.page_source)
end

# Password character returned from value of UIASecureTextField
# @param length [Integer] the length of the password to generate
# @return [String] the returned string is of size length
def password length=1
  '•' * length
end
