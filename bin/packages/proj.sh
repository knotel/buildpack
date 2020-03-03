#!/bin/bash

pkgver=6.3.1
build=$(cd "$1/" && pwd)
cache=$(cd "$2/" && pwd)
env_dir=$(cd "$3/" && pwd)

mkdir -p $build $cache

echo "-----> Downloading PROJ"
if [ ! -s proj-$pkgver.tar.bz2 ]; then
  cd $cache
  curl -Lso proj-$pkgver.tar.bz2 \
    "https://download.osgeo.org/proj/proj-$pkgver.tar.gz" \
    | indent
fi

echo "-----> Unarchiving PROJ"
if [ ! -s proj-$pkgver ]; then
  cd $cache
  mkdir -p proj-$pkgver
  tar -xf proj-$pkgver.tar.bz2
fi

echo "-----> Building PROJ"
if [ ! -s "$cache/proj-$pkgver/src/.libs/libproj.a" ]; then
  cd $cache/proj-$pkgver
  ./configure --prefix=$build | indent
  make | indent
fi

echo "-----> Installing PROJ"
if [ ! -s "$build/lib/libproj.a" ]; then
  cd $cache/proj-$pkgver
  make install | indent
fi
