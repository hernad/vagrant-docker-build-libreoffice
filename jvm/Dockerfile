FROM hernad/precise-i386

RUN apt-get -y update

RUN mkdir -p /root/jvm

RUN apt-get install  -y git mercurial zip bzip2 unzip tar
RUN  apt-get install -y ccache make gcc g++ ca-certificates ca-certificates-java
RUN  apt-get install -y libX11-dev libxext-dev libxrender-dev libxtst-dev  
RUN  apt-get install -y libasound2-dev libcups2-dev libfreetype6-dev
RUN  apt-get install -y build-essential ruby-dev
RUN  apt-get install -y openjdk-7-jdk curl
#RUN gem install fpm

RUN echo "#!/bin/bash" > /bin/uname
RUN echo "case \"\$1\" in" >> /bin/uname
RUN echo " -s )" >> /bin/uname
RUN echo "   echo \"Linux\" ;; " >> /bin/uname
RUN echo " -m ) " >> /bin/uname
RUN echo "   echo \"i686\" ;; " >> /bin/uname
RUN echo " -r ) " >> /bin/uname
RUN echo "   echo \"3.13.0-24-generic\" ;;" >> /bin/uname
RUN echo " * )" >> /bin/uname
RUN echo "  echo \"Linux ubuntu1404-vbox-i386-1 3.13.0-24-generic #47-Ubuntu SMP Fri May 2 23:31:42 UTC 2014 i686 i686 i686 GNU/Linux\" ;; " >> /bin/uname
RUN echo "esac" >> /bin/uname
RUN chmod +x /bin/uname

WORKDIR /root/jvm
RUN git clone https://github.com/hgomez/obuildfactory.git
RUN JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386  XUSE_NEW_BUILD_SYSTEM=true XBUILD=true CPU_BUILD_ARCH=x86 ./obuildfactory/openjdk8-javafx/linux/standalone-job.sh ; echo ok
# prvi poziv uvijek uspjesan (da se ne ponavlja hg pull kod build-a stalno)
RUN JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386  XUSE_NEW_BUILD_SYSTEM=true XBUILD=true CPU_BUILD_ARCH=x86 ./obuildfactory/openjdk8-javafx/linux/standalone-job.sh

WORKDIR  /root/jvm/OBF_DROP_DIR/openjdk8
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no j2sdk-image-i686-*.tar.bz2  root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32/JVM_Platform.tar.bz2
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no j2jre-image-i686-*.tar.bz2  root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32/JVM_Platform_sdk.tar.bz2

RUN ssh -i /root/hernad_ssh.key -o StrictHostKeyChecking=no root@files.bring.out.ba chown hernad /mnt/HD/HD_a2/bringout/Platform/linux32/JVM_Platform*
 
 