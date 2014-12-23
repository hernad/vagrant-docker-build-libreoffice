FROM hernad/precise-i386

#RUN echo "deb http://archive.ubuntu.com.ba/ubuntu/ trusty main universe restricted" > /etc/apt/sources.list
#RUN echo "deb-src http://archive.ubuntu.com.ba/ubuntu/ trusty main universe restricted" >> /etc/apt/sources.list

#RUN echo "deb http://archive.ubuntu.com.ba/ubuntu/ trusty-updates main universe restricted" >> /etc/apt/sources.list
#RUN echo "deb-src http://archive.ubuntu.com.ba/ubuntu/ trusty-updates main universe restricted" >> /etc/apt/sources.list

#RUN echo "deb http://archive.ubuntu.com.ba/ubuntu/ trusty-security main universe restricted" >> /etc/apt/sources.list
#RUN echo "deb-src http://archive.ubuntu.com.ba/ubuntu/ trusty-security main universe restricted" >> /etc/apt/sources.list

RUN apt-get -y update

RUN mkdir -p /root/lo
ADD lobuild/libreoffice_core.tar.gz /root/lo

WORKDIR /root/lo
RUN apt-get -y install wget curl git
RUN git checkout -f

RUN apt-get -y update
RUN apt-get -y build-dep  libreoffice

ADD *.diff /root/lo/
RUN patch -f -p1 < test_off.diff ; echo ignore patch exit
# product LibreOffice -> LO_Platform
RUN patch -f -p1 < lo_platform_configure_ac.diff ; echo ignore patch exit

RUN ./autogen.sh --host=i586-unknown-linux-gnu --disable-crashdump --disable-sdremote --disable-telepathy --disable-cve-tests --disable-online-update --disable-liblangtag --with-build-version="Built by hernad"  --disable-gltf --without-galleries --enable-release-build --enable-epm --with-package-format="deb rpm"

RUN make

WORKDIR /root/lo/instdir
RUN zip -r LO_Platform.zip LIC* CRE* NOT* help presets program share
RUN zip -r LO_Platform_sdk.zip sdk

ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key

RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no LO_Platform.zip root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no LO_Platform_sdk.zip root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32/

RUN ssh -i /root/hernad_ssh.key -o StrictHostKeyChecking=no LO_Platform.zip root@files.bring.out.ba chown hernad /mnt/HD/HD_a2/bringout/Platform/linux32/LO_Platform*.zip
 
CMD ["bash"]
