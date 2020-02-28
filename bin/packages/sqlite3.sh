#!/bin/bash

pkgver=3310100
build=$(cd "$1/" && pwd)
cache=$(cd "$2/" && pwd)
env_dir=$(cd "$3/" && pwd)

echo "-----> Downloading SQLite"
if [ ! -s sqlite-autoconf-$pkgver.tar.gz ]; then
  cd $cache
  curl -Lso sqlite-autoconf-$pkgver.tar.gz \
    https://sqlite.org/2020/sqlite-autoconf-$pkgver.tar.gz \
    | indent
fi

echo "-----> Unarchiving SQLite"
if [ ! -s sqlite-autoconf-$pkgver ]; then
  cd $cache
  mkdir -p sqlite-autoconf-$pkgver
  tar -xf sqlite-autoconf-$pkgver.tar.gz
fi

echo "-----> Building SQLite"
if [ ! -s "$build/lib/libsqlite3.a" ]; then
  cd $cache/sqlite-autoconf-$pkgver
  ./configure --prefix=$build | indent
  make | indent
  cd ..
fi

echo "-----> Installing SQLite"
if [ ! -s "$build/lib/libsqlite3.a" ]; then
  cd $cache/sqlite-autoconf-$pkgver
  make install | indent

  if [ ! -f $env_dir/BUNDLE_BUILD__SQLITE3 ]
  then
    touch $env_dir/BUNDLE_BUILD__SQLITE3
  fi
  echo "--with-sqlite3-dir=$build" >> $env_dir/BUNDLE_BUILD__SQLITE3
fi
