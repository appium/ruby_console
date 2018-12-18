[![Downloads](https://img.shields.io/gem/dt/appium_console.svg)](https://rubygems.org/gems/appium_console)

# Appium Ruby Console

- [appium_console on RubyGems](https://rubygems.org/gems/appium_console)

## How to use
1. Setup Appium
    - Read [a setup guide](http://appium.io/docs/en/about-appium/getting-started/?lang=en)
2. Install `appium_console`
    ```bash
    gem uninstall -aIx appium_lib ;\
    gem uninstall -aIx appium_console ;\
    gem install --no-rdoc --no-ri appium_console
    ```
3. Run
    - The `arc` command starts Appium Ruby Console.
        - `arc help` prints a description of all available commands
        - `arc version` prints the current version of appium console and appium lib.
        - `arc setup android` creates `appium.txt` for android in the current working dir.
        - `arc setup ios` creates `appium.txt` for ios in the current working dir.
        - `arc toml FILE` starts arc with toml FILE path

## Documentation

- [ruby_lib](https://github.com/appium/ruby_lib)
