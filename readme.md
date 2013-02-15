# Ruby Console for Appium

Ruby 1.9.3 and Appium from GitHub are required. Run Appium from source with `node server.js -V 1`

# Reset Appium

Reset Appium after pulling the latest changes.

```
# In the appium/ dir after cloning from GitHub
rm -rf node_modules/
npm install .
# Rebuilt test apps if you're testing against them
grunt buildApp:TestApp
# Run downloadApp if UICatalog fails to build.
grunt downloadApp
grunt buildApp:UICatalog
```

Export the path to your .app bundle `MyApp.app` or zipped app bundle `MyApp.app.zip`

`export APP_PATH="MyApp.app"`

Run with

`pry -I . -r console.rb`

#### Documentation

- [iOS UI Automation](http://developer.apple.com/library/ios/#documentation/DeveloperTools/Reference/UIAutomationRef/_index.html) Example use `@driver.execute_script "UIATarget.localTarget().frontMostApp().mainWindow().rect()"
`
- [Ruby selenium-webdriver](http://selenium.googlecode.com/svn/trunk/docs/api/rb/index.html)
- [Appium](https://github.com/appium/appium/blob/master/README.md)
- [Appium extension](https://github.com/appium/appium/wiki/Automating-mobile-gestures)
- [mechanic names of elements](https://github.com/jaykz52/mechanic/blob/8c490e1d225f384847e47ffdafb47cc2248bb96c/src/mechanic-core.js#L28)

Example use of Appium's mobile gesture.

> @driver.execute_script 'mobile: tap', :x => 0, :y => 500

`console.rb` uses some code from [simple_test.rb](
https://github.com/appium/appium/blob/82995f47408530c80c3376f4e07a1f649d96ba22/sample-code/examples/ruby/simple_test.rb) and is released under the [same license](https://github.com/appium/appium/blob/c58eeb66f2d6fa3b9a89d188a2e657cca7cb300f/LICENSE) as Appium. The [Accessibility Inspector](https://developer.apple.com/library/ios/#documentation/UserExperience/Conceptual/iPhoneAccessibility/Testing_Accessibility/Testing_Accessibility.html) is helpful for discovering button names and textfield values.

#### Driver

`driver` will restart the driver.

`x` will quit the driver and exit Pry.

`execute_script` calls `@driver.execute_script`

#### Buttons

There are two ways to find buttons. The first is to list all buttons and then access the button by index. The second is to access the button by name.

> "name" => "Sign In",
> "type" => "UIAButton",
> "label" => "Sign In",

0. `buttons` returns an array of button names.
0. `e_buttons` returns an array of button elements. `@driver.find_elements :tag_name, :button`
0. `first_button` returns the first button element. `@driver.find_elements(:tag_name, :button).first`
0. `button( name )` Returns the first element that matches name. `@driver.find_element(:name, 'element name')`
0. `button_include( name )` Returns the first button that includes name.
0. `button( name, number )` Returns the button element matching name at the `number` occurrence.
`name='Sign In'` `number=2` will match the 2nd Sign In button.

`first_button.click` clicks the first button.
`@driver.find_elements(:tag_name, :button).first.click`

`find_name 'Sign In'` locates the first element named "Sign In".
`@driver.find_element(:name, 'Sign In')`

#### Text Fields

> "type" => "UIATextField",
> "value" => "Email",

0. `textfields` Returns an array of textfield values.
0. `e_textfields` Returns an array of textfield elements. `@driver.find_elements :tag_name, :textfield`
0. `first_textfield` Returns the first textfield element. `@driver.find_elements(:tag_name, :textfield).first`
0. `textfield( value )` Returns the first textfield that matches value.
0. `textfield_include( value )` Returns the first textfield that includes value.

`first_textfield.send_keys 'hello'` types the word "hello" into the first textfield. 
`@driver.find_elements(:tag_name, :textfield).send_keys 'hello'`

`textfields.first` returns the first textfield element's value.
`@driver.find_elements(:tag_name, :textfield).first.attribute('value')`

```ruby
# Set textfield and assert value
first_textfield.send_keys 'hello'
textfields.first == 'hello'
```

#### Secure Text Fields

> "type" => "UIASecureTextField",
> "value" => "Password",

0. `secure_textfields` Returns an array of secure textfield values.
0. `e_secure_textfields` Returns an array of secure textfield elements. `@driver.find_elements :tag_name, :UIASecureTextField`
0. `first_secure_textfield` Returns the first secure textfield element. `@driver.find_elements(:tag_name, :UIASecureTextField).first`
0. `secure_textfield( value )` Returns the first secure textfield that matches value.
0. `secure_textfield_include( value )` Returns the first secure textfield that includes value.

`password( length )` will return a password of the specified length. It's helpful to check that a secure textfield has been set.

```ruby
# Set secure textfield and assert value
first_secure_textfield.send_keys 'hello'
secure_textfields.first == password(5)
```

#### Static Text

> "type" => "UIAStaticText",

0. `texts` Returns an array of text names.
0. `e_texts` Returns an array of text elements. `@driver.find_elements :tag_name, :text`
0. `first_text` Returns the first text element. `@driver.find_elements(:tag_name, :text).first`
0. `text( name )` Returns the first element that matches name. `@driver.find_element(:name, 'element name')`
0. `text_include( name )` Returns the first text that includes name.

```ruby
# Find text and check we've found the correct one.
find_text('Incorrect email').text == 'Incorrect email'
```

```ruby
# Commands that work
> a.name
> a.type
> a.tag_name
> a.text
> a.size
> a.location
```

`patch.rb` provides:

0. `a.name` `self.attribute :name`
0. `a.type` `self.attribute :type`
0. `a.tag_name` `type`

[routing.js](https://github.com/appium/appium/blob/master/app/routing.js#L69) contains a list of not yet implemented end points.

#### Alerts

Selenium has [built in support](https://github.com/appium/appium/issues/161#issuecomment-13443274) for alerts.

```ruby
alert = @driver.switch_to.alert
alert.text
alert.accept
alert.dismiss
```

Appium can list the alert's buttons.

```ruby
alert_buttons = @driver.find_element(:tag_name, :alert).find_elements(:tag_name, :buttons)
alert_buttons[0].text
alert_buttons[0].click
```

Alert buttons can be accessed by element index, button index, or button name. Button name is the most readable.

0. `alert_click( value )` is the same as `@driver.execute_script 'UIATarget.localTarget().frontMostApp().alert().buttons()[value].tap();'`
0. `alert_text` Returns the text of the alert message.
0. `alert_accept` Accepts the alert.
0. `alert_accept_text` Returns the text of the alert accept button.
0. `alert_dismiss` Dismisses the alert.
0. `alert_dismiss_text` Returns the text of the alert dismiss button.

#### Error: EMFILE, too many open files

Run `ulimit -n 9999`. It's a [known issue](https://github.com/appium/appium/issues/148).

#### Slow Tests

`_include` is slow because it checks the attribute on each tag after enumerating all tags of a certain type.

#### Raw UIAutomation

`execute_script "au.lookup('button')[0].tap()"` is the same as
`execute_script 'UIATarget.localTarget().frontMostApp().buttons()[0].tap()'`

See [app.js](https://github.com/appium/appium/blob/master/app/uiauto/appium/app.js#L3) for more au methods.
Note that raw UIAutomation commands are not offically supported.


