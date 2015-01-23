FROM hernad/precise-i386

RUN echo hb v2
RUN apt-get -y update
RUN apt-get -y install wget curl git zip unzip
RUN apt-get -y install build-essential bison flex libcups2-dev libcurl4-nss-dev libssl-dev libmysqlclient-dev

RUN mkdir -p /root/hb

ADD *.sh /root/hb/
ADD *.config /root/hb/
RUN chmod +x /root/hb/*.sh
ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key

WORKDIR /root/hb
RUN ./get_hb_git.sh
RUN git checkout -f
RUN ./build_harbour.sh

WORKDIR /root/Platform/HB
RUN zip -r HB_Platform.zip .
RUN zip -r HB_Platform_sdk.zip .

RUN /root/hb/put_build_to_file_server.sh

CMD ["bash"]
