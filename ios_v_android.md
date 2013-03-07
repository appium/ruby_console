#### Notes on iOS and Android Appium compatibility

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
