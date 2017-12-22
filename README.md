# GraphicsMagick Ubuntu Packager

The most recent [GraphicsMagick](http://www.graphicsmagick.org/) package for Ubuntu is 1.3.18 which dates back to 2013.

The `build.sh` script here takes a [GraphicsMagick source distribution](https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/), configures, builds and packages it.

To build a new packaged version:

1. Copy the GraphicsMagick source `.tar.gz` archive to this directory (e.g. `GraphicsMagick-1.3.27.tar.gz`)
2. Run `build.sh`.

To install the packaged version that this script creates, use:

```
sudo dpkg -i ./graphicsmagick_1.3.27_amd64.deb
sudo apt-get -f install
```

The initial `dpkg` command may report missing dependencies, the `apt-get` command will ensure those dependencies are satisfied.

NOTE:
1. The build script assumes that [fpm](https://rubygems.org/gems/fpm) is installed.
2. The build configuration was taken from the 1.3.18 package (the `gm version` command line shows build configuration used).
3. The dependency list was taken from the 1.3.18 package