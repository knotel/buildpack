#!/bin/bash

pkgver=3.8.0
build=$(cd "$1/" && pwd)
cache=$(cd "$2/" && pwd)
env_dir=$(cd "$3/" && pwd)

mkdir -p $build $cache

echo "-----> Downloading GEOS"
if [ ! -s geos-$pkgver.tar.bz2 ]; then
  cd $cache
  curl -Lso geos-$pkgver.tar.bz2 \
    "http://download.osgeo.org/geos/geos-$pkgver.tar.bz2" \
    | indent
fi

echo "-----> Unarchiving GEOS"
if [ ! -s geos-$pkgver ]; then
  cd $cache
  mkdir -p geos-$pkgver
  tar -xf geos-$pkgver.tar.bz2
fi

echo "-----> Building GEOS"
if [ ! -s "$build/lib/libgeos.a" ]; then
  cd $cache/geos-$pkgver
  ./configure --prefix=$build | indent
  make | indent
  cd ..
fi

echo "-----> Installing GEOS"
if [ ! -s "$build/lib/libgeos.a" ]; then
  cd $cache/geos-$pkgver
  make install | indent
  echo "--with-geos-dir=$build --with-proj-dir=$build" >> $env_dir/BUNDLE_BUILD__RGEO
fi
