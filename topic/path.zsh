# Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# rbenv
export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH

#RubyGems
export PATH=$HOME/.rbenv/shims:$PATH
export GEM_HOME=$HOME/.rbenv/shims

# PHP 5
# export PATH=/usr/local/php5/bin:$PATH

# Heroku Toolbelt
export PATH=/usr/local/heroku/bin:$PATH

# Chromium Depot Tools
export PATH=$PATH:$HOME/jcefdev/depot_tools

# Go
export GOPATH=$HOME/dev/Go
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin

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

# CMake
export PATH=/Applications/CMake.app/Contents/bin:$PATH

# Swift
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH

# Rust / Multirust
export RUST_SRC_PATH=$HOME/.multirust/src/rust-5a782442d5728041b4c977e73b4fb291213d395b/src
export CARGO_HOME=$HOME/.cargo
export PATH=$CARGO_HOME/bin:$PATH

# Yarn
export PATH="$PATH:`yarn global bin`"

# Swiftenv
# export SWIFTENV_ROOT=$HOME/.swiftenv
# export PATH=$SWIFTENV_ROOT/bin:$PATH
