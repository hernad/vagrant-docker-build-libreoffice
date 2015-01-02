#!/bin/bash

FILE=harbour_core.tar.gz

if [ ! -f ftp_server_path.config ] ; then
   echo nedostaje fajl: ftp_server_path.config
   echo napravicu default config:
   echo "ftp://router-7.bring.out.ba/Main/files/Platform/$FILE" > ftp_server_path.config
   exit 1
fi

if [ ! -f ftp_user_password.config ] ; then
   echo nedostaje fajl: ftp_user_password.onfig
   echo napravicu default config:
   echo 'ftpadmin:password' > ftp_user_password.config
   exit 1
fi


RUN_PARAMS="-L -o $FILE `cat ftp_server_path.config`  --user `cat ftp_user_password.config`"
echo curl run params: $RUN_PARAMS
curl $RUN_PARAMS

echo raspakujem $FILE
tar xvfz $FILE
