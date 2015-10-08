

   export PATH=$PATH:/opt/vagrant/bin

   cd f18; docker build -t f18_linux32 -f Dockerfile.f18_linux32 .


vagrant up lo_platform_linux32
===========================================

1) ftp://files.bring.out.ba/bringout/build/libreoffice_core.tar.gz 
   => lobuild
   mv $USERPROFILE/Downloads/libreoffice_core_tar.gz lobuild
   
2) mv $USERPROFILE/Downloads/hernad_ssh.key .

   (redmine #35803 hernad_ssh.key)
  

vagrant up psql_platform_linux32
===========================================================

1) kopirati hernad_ssh.key u postgresql/ 



## postgresql linux32 

vagrant up psql_platform_linux32 --provider=docker


## libreoffice

vagrant up lo_platform_linux32 --provider=docker

