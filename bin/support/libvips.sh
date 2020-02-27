#!/bin/sh

echo "-----> Downloading libvips"
if [ ! -s vips-8.9.1.tar.gz ]; then
  cd $cache
  curl -Lso vips-8.9.1.tar.gz \
    https://github.com/libvips/libvips/releases/download/v8.9.1/vips-8.9.1.tar.gz \
    | indent
fi

echo "-----> Unarchiving libvips"
if [ ! -s vips-8.9.1 ]; then
  cd $cache
  mkdir -p vips-8.9.1
  tar -xf vips-8.9.1.tar.gz
fi

echo "-----> Building libvips"
if [ ! -s "$build/vendor/libvips" ]; then
  cd $cache/vips-8.9.1
  ./configure --prefix=$build/vendor/libvips | indent
  make | indent
  cd ..
fi

echo "-----> Installing SQLite"
if [ ! -s "$build/vendor/libvips" ]; then
  cd $cache/vips-8.9.1
  make install | indent
fi
