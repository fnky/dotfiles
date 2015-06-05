# Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# rbenv
export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH

#RubyGems
export PATH=$HOME/.rbenv/shims:$PATH
export GEM_HOME=$HOME/.rbenv/shims

# PHP 5
export PATH=/usr/local/php5/bin:$PATH

# Heroku Toolbelt
export PATH=/usr/local/heroku/bin:$PATH

# Chromium Depot Tools
export PATH=$PATH:$HOME/jcefdev/depot_tools

# Go
export GOPATH=$HOME/dev/Go
export PATH=$PATH:/usr/local/opt/go/libexec/bin

#Dart
export PATH=$PATH:$HOME/dart/dart-sdk/bin

# Composer
export PATH=$PATH:$HOME/.composer/vendor/bin

# Some CFLAGS and CPPFLAGS
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments

export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig
export JAVA_HOME=$(/usr/libexec/java_home)
export SCALA_HOME=/usr/local/share/scala
export PATH=$PATH:$SCALA_HOME/bin

# JCEF GYP
export GYP_GENERATORS=xcode
export GYP_DEFINES="jcef_platform=macosx64 jdk_directory=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home target_arch=x64"
