#### Getting Started

This document is written for OS X. Appium does not yet work on Windows.
Appium Android should run on Linux however iOS testing requires OS X.

- Ensure you have Ruby 1.9.3+ (1.8 is not supported). Install the latest stable patch release of Ruby 1.9.3 (not Ruby 2.0).

`$ \curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3`

- Make sure RVM is using the correct Ruby by default

```
$ rvm list
$ rvm --default use 1.9.3
```

- Check that it's installed properly by printing the ruby version.

`$ ruby --version`

- Update RubyGems and Bundler.

```ruby
gem update --system ;\
gem install --no-rdoc --no-ri bundler ;\
gem update bundler
```

- Install appium_console gem.

```ruby
gem uninstall -aIx appium_lib ;\
gem uninstall -aIx appium_console ;\
gem install --no-rdoc --no-ri appium_console
```

- Install [nodejs](http://nodejs.org/) using the big green install button. Node should be `v0.10.1` or better.
If you have `brew` installed then `brew install node` can be run instead of the nodejs.org pkg.
The advantage of using brew is that npm commands will not require sudo.

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

`$ git clone git://github.com/appium/appium.git`

- Run reset.sh. You may have to run this twice as described below due to permission issues.
If you installed node with brew, reset only has to be run once and doesn't require sudo.

`cd appium; sudo ./reset.sh; ./reset.sh`

- Start appium. `-V` enables verbose and `--fast-reset` enables fast rest for Android.

`node server.js -V --fast-reset`

- Install `Intel x86 Emulator Accelerator (HAXM)` under Extras using the `android`` tool.
- Use Intel [system image](http://software.intel.com/en-us/articles/android-4-2-jelly-bean-x86-emulator-system-image)
at least API 17 (Jelly Bean). This is also installed via the `android` tool.

- Install using Android package tool. For API 17, install `SDK Platform`, `Intel x86 Atom System Image`, `Google APIs` as in the picture. 
If there are any problems viewing or downloading the packages, go to `Packages -> Reload` and try again.

`android`

![](img/packages.png)

- Create a new Android virtual device that uses the Intel image.

`android avd`

![](img/avd_settings.png)

- Check that `hax is working`

![](img/hax.png)

- After launching the emulator, check that it's listed in adb devices. Run the following commands a few times until it's listed.

`adb kill-server; adb devices`

If you see `error: protocol fault (no status)` just keep running the command until the emulator is detected.

- With both the Android emulator running and the Appium server started, it's time to launch the appium console. Make sure the ENV vars are exported.

APP_ACTIVITY is the activity to start the app with.
APP_WAIT_ACTIVITY is the activity to wait for before considering the app as having been started.

```
export APP_PATH="/path/to/my.apk" ;\
export APP_PACKAGE="com.my.Pkg" ;\
export APP_ACTIVITY="StartActivity"
export APP_WAIT_ACTIVITY="SplashActivity"
```

- Echo the values to make sure they're set correctly

`$ echo $APP_PATH $APP_PACKAGE $APP_ACTIVITY $APP_WAIT_ACTIVITY`

- Start appium console

`arc`
