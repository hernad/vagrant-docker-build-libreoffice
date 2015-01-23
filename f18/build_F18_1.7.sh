#!/bin/bash

export HB_PLATFORM=linux

HOME_BUILD=/root
HOME_PLATFORM=$HOME_BUILD/Platform
export HB_ROOT=$HOME_PLATFORM/HB

export HB_USER_CFLAGS=-m32
export HB_WITH_QT=/root/Platform/Qt/5.4/gcc/include

export HB_WITH_PGSQL=$HOME_PLATFORM/PSQL/include
export HB_INSTALL_PREFIX=$HB_ROOT
export PATH=$HB_WITH_QT/../bin:$PATH

mkdir $HOME_BUILD/F18_knowhow
cd $HOME_BUILD/F18_knowhow

git checkout -f 1.7
git clean -d -fx
git pull
source scripts/ubuntu_set_envars.sh

./build_release.sh

chmod 0700 $HOME/*.key

scripts/build_gz.sh XX --push
