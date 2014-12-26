FROM hernad/precise-i386

RUN apt-get -y update
RUN apt-get install  -y git mercurial zip bzip2 unzip tar
RUN  apt-get install -y ccache make gcc g++ ca-certificates ca-certificates-java
RUN  apt-get install -y libX11-dev libxext-dev libxrender-dev libxtst-dev  
RUN  apt-get install -y libasound2-dev libcups2-dev libfreetype6-dev
RUN  apt-get install -y build-essential ruby-dev
RUN  apt-get install -y openjdk-7-jdk curl

RUN apt-get install -y bison flex gperf libasound2-dev libgl1-mesa-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libjpeg-dev libpng-dev libx11-dev libxml2-dev libxslt1-dev libxt-dev libxxf86vm-dev pkg-config qt4-qmake x11proto-core-dev x11proto-xf86vidmode-dev libavcodec-dev mercurial libgtk2.0-dev ksh libxtst-dev libudev-dev

RUN apt-get install -y pkg-config libxtst-dev libgtk2.0-dev libavcodec-dev libavformat-dev
 
#RUN gem install fpm

# passwordless ssh to-from files.bring.out.ba
ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key


RUN mkdir -p /root/jvm

# prilagodi da build skripte sistem vide kao x86 a ne x86_64

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

#RUN curl -L -o /root/jvm/gradle.zip http://services.gradle.org/distributions/gradle-2.2.1-bin.zip
#java builder kaze da je kompatibilan sa 1.8 gradle-om
RUN curl -L -o /root/jvm/gradle.zip http://services.gradle.org/distributions/gradle-1.8-bin.zip

RUN unzip gradle.zip

# rm /root/jvm/sources/openjdk8-javafx-openjfx/build/linux_tools.properties


RUN git clone https://github.com/hgomez/obuildfactory.git
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no   root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/jvm_hg.tar.gz /root/jvm/jvm_hg.tar.gz
RUN tar xfz jvm_hg.tar.gz

RUN PATH=/root/jvm/gradle-1.8/bin:$PATH JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386  XUSE_NEW_BUILD_SYSTEM=true XBUILD=false ./obuildfactory/openjdk8-javafx/linux/standalone-job.sh ; echo ok
RUN PATH=/root/jvm/gradle-1.8/bin:$PATH JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386  XUSE_NEW_BUILD_SYSTEM=true XBUILD=true ./obuildfactory/openjdk8-javafx/linux/standalone-job.sh

WORKDIR  /root/jvm/OBF_DROP_DIR/openjdk8
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no  j2sdk-image-i686-*-`date +%Y%m%d`.tar.bz2  root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32/JVM_Platform_sdk.tar.bz2
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no  j2re-image-i686-*-`date +%Y%m%d`.tar.bz2  root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32/JVM_Platform.tar.bz2

RUN ssh -i /root/hernad_ssh.key -o StrictHostKeyChecking=no root@files.bring.out.ba chown hernad /mnt/HD/HD_a2/bringout/Platform/linux32/JVM_Platform*
 
