#### Getting Started

Only OS X is supported.

- Clone ruby_console

`$ git clone git://github.com/appium/ruby_console.git`

- Ensure you have Ruby 1.9.3+ (1.8 is not supported). If you don't have 1.9.3+, install it with rvm.

`$ ruby --version`

- Install ruby_console gems.

`gem install rest-client bundler pry selenium-webdriver ap crack`

- Install [nodejs](http://nodejs.org/)

`$ node --version`

`$ npm --version`

- Install grunt.

` sudo npm install -g grunt grunt-cli`

```bash
$ grunt --version
grunt-cli v0.1.6
grunt v0.4.1
```

- Clone appium

`$ git clone git@github.com:appium/appium.git`

- Run reset.sh. You may have to run this twice as described below due to permission issues.

`cd appium; sudo ./reset.sh; ./reset.sh`

- Start appium. `-V` enables verbose and `--fast-reset` enables fast rest for Android.

`node server.js -V --fast-reset`

- Install dmg [hax module](http://software.intel.com/en-us/articles/intel-hardware-accelerated-execution-manager)
- Use intel [system image](http://software.intel.com/en-us/articles/android-4-2-jelly-bean-x86-emulator-system-image) at least API 17 (Jelly Bean)

`android avd`

![](img/avd_settings.png)
