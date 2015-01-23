FROM hernad/precise-i386

RUN echo hb v2
RUN apt-get -y update
RUN apt-get -y install wget curl git zip unzip
RUN apt-get -y install build-essential bison flex libcups2-dev libcurl4-nss-dev libssl-dev libmysqlclient-dev libx11-dev

RUN echo workaround da se sistem prepozna kao 32bit
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

RUN echo F18_knowhow 1.7 build
RUN mkdir -p /root/F18_knowhow
ADD *.sh /root/F18_knowhow/
ADD *.config /root/F18_knowhow/
RUN chmod +x /root/F18_knowhow/*.sh
ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key

WORKDIR /root/F18_knowhow
RUN ./get_f18_deps.sh


RUN ./build_F18_1.7.sh

CMD ["bash"]
