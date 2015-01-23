FROM hernad/precise-i386

RUN echo hb v2
RUN apt-get -y update
RUN apt-get -y install wget curl git zip unzip
RUN apt-get -y install build-essential bison flex libcups2-dev libcurl4-nss-dev libssl-dev libmysqlclient-dev libx11-dev

RUN mkdir -p /root/f18

ADD *.sh /root/f18/
ADD *.config /root/f18/
RUN chmod +x /root/f18/*.sh
ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key

WORKDIR /root/f18
RUN ./get_f18_deps.sh
RUN git checkout -f
RUN ./build_F18_1.7.sh

RUN /root/f18/put_build_to_file_server.sh

CMD ["bash"]
