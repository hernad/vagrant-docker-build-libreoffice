FROM hernad/precise-i386

RUN apt-get -y update
RUN apt-get -y install wget curl git
RUN apt-get -y build-essentials bison flex libpq-dev

RUN mkdir -p /root/lo

#ADD lobuild/libreoffice_core.tar.gz /root/lo
ADD *.sh /root/hb
RUN chmod +x /root/hb/*.sh
ADD *.diff /root/hb/
ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key

WORKDIR /root/hb
RUN ./get_hb_git.sh
RUN git checkout -f

RUN HB_INSTALL_PREFIX=/root/HB_Platform make

WORKDIR /root/HB_Platform
RUN zip -r HB_Platform.zip .
RUN zip -r HB_Platform_sdk.zip .

RUN /root/hb/put_build_to_file_server.sh

CMD ["bash"]
