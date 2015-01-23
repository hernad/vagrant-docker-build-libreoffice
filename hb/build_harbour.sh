#!/bin/bash

#/root/Platform/
#/root/Platform/Qt/5.4/
#/root/Platform/PSQL/

export HB_PLATFORM=linux
export HB_ROOT=/root/Platform/HB
mkdir -p $HB_ROOT
 
export HB_USER_CFLAGS=-m32
#export HB_USER_DFLAGS='-m32 -L/usr/lib32'
#export HB_USER_LDFLAGS='-m32 -L/usr/lib32'
export HB_WITH_QT=/root/Platform/Qt/5.4/gcc/include
export HB_WITH_PGSQL=/root/Platform/PSQL/include
export HB_INSTALL_PREFIX=$HB_ROOT

export PATH=$HB_WITH_QT/../bin:$PATH

cd /root/hb
git checkout -f F18_master
make install

