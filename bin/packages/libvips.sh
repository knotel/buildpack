#!/bin/bash

pkgver=8.9.1
build=$(cd "$1/" && pwd)
cache=$(cd "$2/" && pwd)
env_dir=$(cd "$3/" && pwd)

mkdir -p $build $cache

echo "-----> Downloading libvips"
if [ ! -s vips-$pkgver.tar.gz ]; then
  cd $cache
  curl -Lso vips-$pkgver.tar.gz \
    "https://github.com/libvips/libvips/releases/download/v$pkgver/vips-$pkgver.tar.gz" \
    | indent
fi

echo "-----> Unarchiving libvips"
if [ ! -s vips-$pkgver ]; then
  cd $cache
  mkdir -p vips-$pkgver
  tar -xf vips-$pkgver.tar.gz
fi

echo "-----> Building libvips"
if [ ! -s "$build/lib/libvips.a" ]; then
  cd $cache/vips-$pkgver
  ./configure --prefix=$build | indent
  make | indent
  cd ..
fi

echo "-----> Installing libvips"
if [ ! -s "$build/lib/libvips.a" ]; then
  cd $cache/vips-$pkgver
  make install | indent
fi
