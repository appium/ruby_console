#### Appium Ruby Console [![Gem Version](https://badge.fury.io/rb/appium_console.png)](http://rubygems.org/gems/appium_console)[![Dependency Status](https://gemnasium.com/appium/ruby_console.png)](https://gemnasium.com/appium/ruby_console)

- [appium_console on RubyGems](https://rubygems.org/gems/appium_console)

#### How to use

Read the [bootcamp guide on the ruby console](https://saucelabs.com/resources/appium-bootcamp/appium-bootcamp-2013-chapter-2-the-console).

#### Update system

Paste the following into Terminal. If you're not using [RVM](https://rvm.io/), you may have to prefix gem commands with sudo.

```bash
gem update --system ;\
gem update bundler
```

#### Pry commands

Pry commands are prefixed with `%`. For example `%reset` invokes Pry's reset command.
To use the ruby_lib reset, it's `reset`

#### Install / Upgrade Ruby Console

```bash
gem uninstall -aIx appium_lib ;\
gem uninstall -aIx appium_console ;\
gem install --no-rdoc --no-ri appium_console bond
```

The bond gem is necessary for proper auto complete. Installing it will fix this error `NameError: uninitialized constant Pry::BondCompleter::Bond`

If `appium_console` is already installed, run `arc upgrade` to automatically update.

#### Notes

You should uninstall the `ap` gem because it breaks awesome_print.

`gem uninstall -aIx ap`

#### Run

The `arc` command starts Appium Ruby Console.

- `arc version` prints the current version of appium console and appium lib.
- `arc upgrade` upgrades appium_console and appium_lib.
- `arc setup android` creates `appium.txt` for android in the current working dir.
- `arc setup ios` creates `appium.txt` for ios in the current working dir.

#### Documentation

- [Installing Appium on OS X](https://github.com/appium/ruby_console/blob/master/osx.md)
- [Overview](https://github.com/appium/ruby_lib/blob/master/docs/docs.md) 
- [Android methods](https://github.com/appium/ruby_lib/blob/master/docs/android_docs.md)
- [iOS methods](https://github.com/appium/ruby_lib/blob/master/docs/ios_docs.md)
- [Appium docs](https://github.com/appium/appium/tree/master/docs)
