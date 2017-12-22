#!/bin/bash
GM_SOURCE_ARCHIVE=$(ls GraphicsMagick*.tar.gz)
GM_SOURCE=${GM_SOURCE_ARCHIVE%.tar.gz}
GM_VERSION=${GM_SOURCE#*-}

TARGET_DIR=$PWD/source
mkdir $TARGET_DIR

echo "Extracting source from $GM_SOURCE_ARCHIVE"
tar xzf $GM_SOURCE_ARCHIVE

echo "Configuring $GM_SOURCE"
cd $GM_SOURCE
./configure  '--build' 'x86_64-linux-gnu' '--disable-installed' '--disable-shared' '--enable-libtool-verbose' --prefix=$TARGET_DIR '--mandir=${prefix}/share/man' '--infodir=${prefix}/share/info' '--docdir=${prefix}/share/doc/graphicsmagick' '--with-gs-font-dir=/usr/share/fonts/type1/gsfonts' '--with-x' '--x-includes=/usr/include/X11' '--x-libraries=/usr/lib/X11' '--without-dps' '--without-modules' '--without-frozenpaths' 'build_alias=x86_64-linux-gnu' 'CFLAGS=-Wall -g -fno-strict-aliasing  -fPIE  -fstack-protector --param ssp-buffer-size=4  -D_FORTIFY_SOURCE=2  -Wformat -Wformat-security -Werror=format-security  -O2' 'LDFLAGS=  -fPIE -pie  -Wl,-z,relro  -Wl,-z,now ' 'CXXFLAGS=-Wall -g -fno-strict-aliasing  -fPIE  -fstack-protector --param ssp-buffer-size=4  -D_FORTIFY_SOURCE=2  -Wformat -Wformat-security -Werror=format-security  -O2'

echo "Building $GM_SOURCE"
make install
cd ..

echo "Packaging $GM_SOURCE"
rm -f *.deb
fpm -s dir -t deb -C $TARGET_DIR --prefix /usr -n graphicsmagick -v $GM_VERSION -d libbz2-1.0 -d libc6 -d libfreetype6 -d libgomp1 -d libjasper1 -d libjbig0 -d libjpeg8 -d liblcms2-2 -d libpng12-0 -d libtiff5 -d libwmf0.2-7 -d libx11-6 -d libxext6 -d libxml2 -d zlib1g

echo "Cleaning up"
rm -rf $TARGET_DIR
rm -rf $GM_SOURCE
