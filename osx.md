### Getting Started

This document is written for OS X 10.8.4 or better. iOS testing requires OS X. Android testing works on OS X, Windows, and Linux. 

For OS X, there is rake script which will attempt to do most of this for you, with
```
rake -f install_osx.rake
```
The rake script will not install Xcode, etc., nor Java, but should take care of everything else. 
Changes to these instructions might imply changes to that script as well.

#### Steps to install

Install `Xcode` 4.6.3 (iOS 6) or 5.0.0 (iOS 7).

- Xcode 5.0.0 shouldn't be used for iOS 6 as it's flaky.
- Xcode 5.0.1 is broken.
- Xcode 4.6.3 doesn't support iOS 7.

After that, install the command line build tools (Xcode -> Preferences -> Downloads).
 
If you're testing iOS 6, then install `Xcode 4.6.3` from [Apple](https://developer.apple.com/downloads/index.action).
For iOS 7+ make sure to use Xcode 5.

That done, you'll need to create a symlink for
`gcc` to get the ruby build (particularly FFI) to install properly. 
If `/usr/local/bin` is in your path, you can do:
```
ln -s /usr/bin/gcc /usr/local/bin/gcc-4.2
```
Otherwise
```
sudo ln -s /usr/bin/gcc /usr/bin/gcc-4.2
```
Reinstall Ruby if you didn't set this symlink and have FFI issues.

- Install Java 7 if there's no Java on the system.
  - [JDK 7](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

- Install the latest stable patch release of Ruby 2.0.

`$ \curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0`

- Make sure RVM is using the correct Ruby by default

```
$ rvm list
$ rvm --default use 2.0.0
```

- If you have an old ruby, you can installing Ruby 2.0 instead

```
$ rvm get stable
$ rvm install 2.0.0
```

- Check that it's installed properly by printing the ruby version.

`$ ruby --version`

- Update RubyGems and Bundler.

```ruby
gem update --system ;\
gem install --no-rdoc --no-ri bundler ;\
gem update ;\
gem cleanup
```

- Check that RubyGems is >= 2.1.5

```bash
$ gem --version
2.1.5
```

- Install appium_console gem.

```ruby
gem uninstall -aIx appium_lib ;\
gem uninstall -aIx appium_console ;\
gem install --no-rdoc --no-ri appium_console
```

- Install [flaky](https://github.com/appium/flaky) gem.

```ruby
gem uninstall -aIx flaky ;\
gem install --no-rdoc --no-ri flaky
```

- Install [brew](http://mxcl.github.io/homebrew/)

`ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"`

- Install [nodejs](http://nodejs.org/) using brew.

```
brew update ;\
brew upgrade node ;\
brew install node
```

- Node should be `v0.10.5` or better.
Don't use the big green install button on nodejs.org or all npm commands will require sudo.

`$ node --version`

`$ npm --version`

- Install grunt.

`npm install -g grunt grunt-cli`

```bash
$ grunt --version
grunt-cli v0.1.6
grunt v0.4.1
```

- Install [ant](http://ant.apache.org/) if it's not already installed.
- Install [maven](http://maven.apache.org/download.cgi) if it's not already installed.

```
$ ant -version
Apache Ant(TM) version 1.8.2 compiled on June 20 2012
$ mvn -version
Apache Maven 3.0.3 (r1075438; 2011-02-28 12:31:09-0500)
```

- Clone appium

`$ git clone git://github.com/appium/appium.git`

- Run reset.sh

`cd appium; ./reset.sh`

If you see config errors, try cleaning git. `git clean -dfx; git reset --hard`

You can also reset by platform. `./reset.sh --android`


- Authorize for iOS testing. Must run reset.sh as mentioned above before running the grunt task.

> sudo \`which grunt\` authorize

- Start appium.

`node server.js`


#### Bash Profile
- Add the Android SDK tools folder to your path so you can run `android`.
- Define the `ANDROID_HOME` env var pointing to SDK root. On OSX place it in `~/.bash_profile`
- You may have to add grunt as well `/usr/local/share/npm/bin/grunt`

```
# ~/.bash_profile
export ANDROID_HOME=$HOME/Downloads/android-sdk-macosx
export ANDROID_SDK=$ANDROID_HOME
PATH=$PATH:/Applications/apache-ant-1.8.4/bin
PATH=$PATH:/usr/local/share/npm/bin/
PATH=$PATH:$ANDROID_HOME/build-tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/tools
export JAVA_HOME="`/System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands/java_home`"
export APP_PATH="/path/to/MyiOS.app"
export APK_PATH="/path/to/my.apk"
export APP_PACKAGE="com.example.Package"
export APP_ACTIVITY="StartActivity"
export APP_WAIT_ACTIVITY="SplashActivity"

export PATH
```

- Run `android` to open the SDK manager. 
- Install `Intel x86 Emulator Accelerator (HAXM)` under Extras
- Install API 18 `SDK Platform`, `Intel x86 Atom System Image`, `Google APIs`
If there are any problems viewing or downloading the packages, go to `Packages -> Reload` and try again.

- Create a new Android virtual device that uses the Intel image. Ensure `Use Host GPU` is checked. Set `VM Heap` to `64`. `32` is too small.

![](img/avd_settings.png)

`android avd`

- Check that `hax is working` If it's not, install hax [directly from Intel](http://software.intel.com/en-us/articles/intel-hardware-accelerated-execution-manager)

```bash
$ emulator @t18
HAX is working and emulator runs in fast virt mode
```

- Launch the emulator with `emulator @t18`

- After launching the emulator, check that it's listed in adb devices. Run the following commands a few times until it's listed.

`adb kill-server; adb devices`

If you see `error: protocol fault (no status)` just keep running the command until the emulator is detected.

- With both the Android emulator running and the Appium server started, it's time to launch the appium console. Make sure the ENV vars are exported.

- Echo the values to make sure they're set correctly

`$ echo $APP_PATH $APP_PACKAGE $APP_ACTIVITY $APP_WAIT_ACTIVITY`

- Start appium console

`arc`

- See [running on OS X](https://github.com/appium/appium/blob/master/docs/running-on-osx.md)

#### Troubleshooting

- If install fails, keep trying to install a few times.

When using `Appium.app` make sure to set Appium -> Preferences... -> Check "Use External Appium Package" and set it to the path of Appium cloned from GitHub.

Fix permission errors. npm shouldn't require sudo.

```bash
brew uninstall node
brew install node
rm -rf ./node_modules # run from the appium folder
rm -rf "/Users/`whoami`/.npm"
rm -rf /usr/local/lib/node_modules/ 
./reset.sh --ios
./reset.sh --android
```

- [Helper bash methods](https://gist.github.com/bootstraponline/5580587)

#### SSL Issues

> Unable to download data from https://rubygems.org/ - SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed 

- [Fix SSL issues](http://railsapps.github.io/openssl-certificate-verify-failed.html) with:

```bash
$ rvm osx-ssl-certs update all
$ rvm osx-ssl-certs status all
```

#### Maven on OS X 10.9

```bash
$ cd /usr/local
$ git reset --hard origin/master

$ brew update
$ brew install maven
```

#### HAXM on OS X 10.9

HAXM [doesn't currently support 10.9](http://software.intel.com/en-us/forums/topic/477793). Uninstall using:

> sudo /System/Library/Extensions/intelhaxm.kext/Contents/Resources/uninstall.sh

#### Restore dev tools on 10.9

`xcode-select --install`
