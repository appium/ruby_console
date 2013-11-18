#### Notes on iOS and Android Appium compatibility

#### iOS Ghosting

It's not uncommon to have multiple elements from different pages. To find the correct back button for example,
it's necessary to find all the back buttons `names('Back')` and then return the first one that's displayed.

This has implications for searching by index. If you select textfield 1 for the 1st textfield, then you may
be getting a textfield from a previous page. The solution is to ensure each element has a unique accessibility identifier
and to verify visibility and type.

#### iPhone vs iPad

iPad will contain elements from visible background screens. iPhone will have only one screen, however the keyboard can only be dismissed by clicking somewhere.
The iPad has a hide keyboard button. The iPhone will use `Next` and `Go` on a typical login screen via the on screen keyboard.

- setValue will immediately set the value
- hideKeyboard will attempt to hide the iPad keyboard and fail on iPhone
- find_element(:tag_name, :window).click should work everywhere

##### Tag Names

`secure` is not possible to implement on Android using uiautomator. `textfield` and `secure` are both considered `edittext`.

`textfield` returns all textfields, including secure on Android. `secure` will error on Android.
on iOS `textfield` will not match secure text fields.

##### Search strategy

Android

- `android:id` is not accessible via uiautomator
- `name` content description (defined in activity XML or dynamically)
- `text` text content of the UI widget
- `tag_name` the android class

`text` is [not a selenium search strategy](https://github.com/appium/appium/issues/241#issuecomment-14582659) so use XPath.

`secure` on iOS will return value.

`EditText` used as password field on Andorid will always return an empty string.

--

iOS .name returns the [accessibility attribute](http://developer.apple.com/library/ios/#documentation/ToolsLanguages/Reference/UIAElementClassReference/UIAElement/UIAElement.html#//apple_ref/javascript/instm/UIAElement/name) if it's set. if not set, the string value is used.

Android .name returns the accessibility attribute and nothing if it's not set.

#### More options button

The android `options` button will be hidden if the device has a hardware menu button. To work around this:

```ruby
# see abs__action_menu_overflow_description in ActionBarSherlock
# click more options if it exists. if it doesn't then the device has a hardware menu button that must be pressed instead.
exists { name 'more options' } ? name('more options').click : mobile(:keyevent, keycode: 82)
```

