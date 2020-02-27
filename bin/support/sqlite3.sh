#!/bin/sh

echo "-----> Downloading SQLite"
if [ ! -s sqlite-autoconf-3310100.tar.gz ]; then
  cd $cache
  curl -Lso sqlite-autoconf-3310100.tar.gz \
    https://sqlite.org/2020/sqlite-autoconf-3310100.tar.gz \
    | indent
fi

echo "-----> Unarchiving SQLite"
if [ ! -s sqlite-autoconf-3310100 ]; then
  cd $cache
  mkdir -p sqlite-autoconf-3310100
  tar -xf sqlite-autoconf-3310100.tar.gz
fi

echo "-----> Building SQLite"
if [ ! -s "$build/vendor/sqlite3" ]; then
  cd $cache/sqlite-autoconf-3310100
  ./configure --prefix=$build/vendor/sqlite3 | indent
  make | indent
  cd ..
fi

echo "-----> Installing SQLite"
if [ ! -s "$build/vendor/sqlite3" ]; then
  cd $cache/sqlite-autoconf-3310100
  make install | indent
  echo "--with-sqlite3-dir=$build/vendor/sqlite3" >> $env_dir/BUNDLE_BUILD__SQLITE3
  echo "$LD_LIBRARY_PATH:$build/vendor/sqlite3" >> $env_dir/LD_LIBRARY_PATH
fi