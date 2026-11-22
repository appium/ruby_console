[![Downloads](https://img.shields.io/gem/dt/appium_console.svg)](https://rubygems.org/gems/appium_console)

# Appium Ruby Console

- [appium_console on RubyGems](https://rubygems.org/gems/appium_console)

## How to use
1. Setup Appium
    - Read [a setup guide](http://appium.io/docs/en/about-appium/getting-started/?lang=en)
2. Install `appium_console`
    ```bash
    gem uninstall appium_lib
    gem uninstall appium_console
    gem install appium_console
    ```
3. Run
    - The `arc` command starts Appium Ruby Console.
        - `arc help` prints a description of all available commands
        - `arc version` prints the current version of appium console and appium lib.
        - `arc setup android` creates `appium.txt` for android in the current working dir.
        - `arc setup ios` creates `appium.txt` for ios in the current working dir.
        - Setup preserves an existing `appium.txt`. Add `--force` to overwrite it.
        - `arc toml FILE` starts arc with toml FILE path
        - `arc multi` opens a console where you start and stop each session yourself.

### Managing multiple sessions

Run `arc multi` and load a configuration for each device. Keep each driver
in its own variable and call commands on the driver you want to use.

```ruby
ios = Appium::Driver.new(Appium.load_appium_txt(file: 'ios.txt'), false)
android = Appium::Driver.new(Appium.load_appium_txt(file: 'android.txt'), false)
ios.start_driver
android.start_driver

ios.get_source
android.get_source

ios.driver_quit
android.driver_quit
```

## Documentation

- [ruby_lib](https://github.com/appium/ruby_lib)

## Development

Run `bundle install`, then `bundle exec rake test` and `bundle exec rake rubocop`.
Tests run without an Appium server or device.

## Changelog
- 4.0.0
    - Drop Ruby 2.7 support
- 3.0.0
    - Update ruby_lib version to v12


## Releasing

Review and merge the Release Please PR to publish. See [RELEASING.md](RELEASING.md)
for one-time Trusted Publishing setup and recovery instructions.
