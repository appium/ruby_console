class Selenium::WebDriver::Element
  
  # NoMethodError: undefined method `name' for #<Selenium::WebDriver::Element
  def name
    self.attribute :name
  end
  
  # NoMethodError: undefined method `type' for #<Selenium::WebDriver::Element
  def type
    self.attribute :type
  end
  
  # Tag name appears to be the same as type.
  # Selenium::WebDriver::Error::UnknownError: Not yet implemented
  def tag_name
    type
  end
end