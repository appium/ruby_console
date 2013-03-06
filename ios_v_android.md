#### Notes on iOS and Android Appium compatibility

`secure` is not possible to implement on Android using uiautomator. `textfield` and `secure` are both considered `edittext`.

`textfield` should return all textfields, including secure on Android. `secure` [should error](https://github.com/appium/appium/pull/234) on Android

`android:id` is not accessible via uiautomator.
