#!/bin/bash

FILE=harbour_core.tar.gz

if [ ! -f ftp_server_path.config ] ; then
   echo nedostaje fajl: ftp_server_path.config
   echo napravicu default config:
   echo "ftp://router-7.bring.out.ba/Main/files/Platform" > ftp_server_path.config
   exit 1
fi

if [ ! -f ftp_user_password.config ] ; then
   echo nedostaje fajl: ftp_user_password.onfig
   echo napravicu default config:
   echo 'ftpadmin:password' > ftp_user_password.config
   exit 1
fi

FTP_PATH=`cat ftp_server_path.config`
FTP_PWD=`cat ftp_user_password.config`
function get_file() { 

 FILE=$1

 RUN_PARAMS="-L -o $FILE $FTP_PATH/$FILE  --user $FTP_PWD"
 echo curl run params: $RUN_PARAMS
 curl $RUN_PARAMS
}


cd /root/hb
FILE=harbour_core.tar.gz
get_file $FILE
tar xvfz $FILE

mkdir -p /root/Platform
cd /root/Platform

FILE=Qt_54_linux32.tar.gz
get_file $FILE
tar xvfz $FILE

cd /root/Platform
mkdir PSQL
cd PSQL
FILE=PSQL_Platform_linux32.zip
get_file $FILE
echo raspakujem $FILE
unzip $FILE



