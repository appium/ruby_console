# encoding: utf-8
# UIAWindow methods

def window_size
  return nil if $driver.nil?
  $driver.manage.window.size
end