FROM ubuntu:14.04

RUN apt-get -y update
RUN apt-get -y build-dep libreoffice

RUN mkdir -p /root/lo
ADD lobuild/libreoffice_core.tar.gz /root/lo

WORKDIR /root/lo
RUN apt-get -y install wget curl git
RUN git checkout -f
#RUN tar xvfz  libreoffice_core.tar.gz
RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN apt-get install -y openjdk-7-jdk:i386
RUN ./autogen.sh --host=i586-unknown-linux-gnu --with-jdk-home=/usr/lib/jvm/java-1.7.0-openjdk-i386 --disable-crashdump --disable-sdremote --disable-telepathy --disable-cve-tests --disable-online-update --disable-liblangtag --with-build-version="Built by hernad"  --disable-gltf --without-galleries --enable-release-build
RUN make

CMD ["bash"]
