FROM hernad/precise-i386

RUN apt-get -y update
RUN apt-get -y install wget curl git
RUN apt-get -y build-dep  libreoffice

RUN mkdir -p /root/lo

#ADD lobuild/libreoffice_core.tar.gz /root/lo
ADD *.sh /root/lo/
RUN chmod +x /root/lo/*.sh
ADD *.diff /root/lo/
ADD *.config /root/lo/
ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key

WORKDIR /root/lo
RUN echo get libreoffice .git from file server
RUN ./get_libreoffice_git.sh
RUN git checkout -f

RUN patch -f -p1 < test_off.diff ; echo ignore patch exit
# product LibreOffice -> LO_Platform
RUN patch -f -p1 < lo_platform_configure_ac.diff ; echo ignore patch exit

#RUN ./autogen.sh --host=i586-unknown-linux-gnu --disable-crashdump --disable-sdremote --disable-telepathy --disable-cve-tests --disable-online-update --disable-liblangtag --with-build-version="Built by hernad"  --disable-gltf --without-galleries --enable-release-build --enable-epm --with-package-format="deb rpm"
#RUN apt-get install -y libgstreamer0.10-dev
RUN ./autogen.sh --host=i586-unknown-linux-gnu --disable-crashdump --disable-sdremote --disable-telepathy --disable-cve-tests --disable-online-update --disable-liblangtag --with-build-version="Built by hernad"  --disable-gltf --without-galleries --enable-release-build --disable-gstreamer-1-0 
#--disable-gstreamer-0-10 --disable-avmedia --disable-gstreamer-1-0

RUN make

WORKDIR /root/lo/instdir
RUN zip -r LO_Platform.zip LIC* CRE* NOT* help presets program share
RUN zip -r LO_Platform_sdk.zip sdk

RUN /root/lo/put_build_to_file_server.sh


CMD ["bash"]
