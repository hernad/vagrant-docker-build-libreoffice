FROM hernad/trusty_i386

RUN echo "deb http://archive.ubuntu.com.ba/ubuntu/ trusty main universe restricted" > /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com.ba/ubuntu/ trusty main universe restricted" >> /etc/apt/sources.list

RUN echo "deb http://archive.ubuntu.com.ba/ubuntu/ trusty-updates main universe restricted" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com.ba/ubuntu/ trusty-updates main universe restricted" >> /etc/apt/sources.list

RUN echo "deb http://archive.ubuntu.com.ba/ubuntu/ trusty-security main universe restricted" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com.ba/ubuntu/ trusty-security main universe restricted" >> /etc/apt/sources.list

RUN apt-get -y update

RUN mkdir -p /root/lo
ADD lobuild/libreoffice_core.tar.gz /root/lo
ADD lobuild/lo_cpputests_off.diff /root/lo 
WORKDIR /root/lo
RUN apt-get -y install wget curl git
RUN git checkout -f

RUN apt-get -y update
RUN apt-get -y build-dep  libreoffice

./autogen.sh --host=i586-unknown-linux-gnu --disable-crashdump --disable-sdremote --disable-telepathy --disable-cve-tests --disable-online-update --disable-liblangtag --with-build-version="Built by hernad"  --disable-gltf --without-galleries --enable-release-build

#RUN make
patch -p1 < lo_cpputests_off.diff

CMD ["bash"]
