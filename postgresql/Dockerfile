FROM hernad/precise-i386

RUN apt-get -y update

RUN mkdir -p /root/psql

WORKDIR /root/psql
RUN apt-get -y install libreadline6-dev zip wget curl git
RUN apt-get -y build-dep  postgresql


ADD hernad_ssh.key /root/
RUN chmod 0600 /root/hernad_ssh.key

WORKDIR /root/psql
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/psql_git.tar.gz /root/psql/
RUN tar xvfz psql_git.tar.gz
RUN git checkout -f bdr-pg/REL9_4_STABLE
RUN apt-get -y install bison flex libz-dev
RUN ./configure --prefix=/root/PSQL_Platform
RUN make install


WORKDIR /root/PSQL_Platform
RUN zip -r PSQL_Platform.zip .
RUN scp -i /root/hernad_ssh.key -o StrictHostKeyChecking=no PSQL_Platform.zip root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32/

RUN ssh -i /root/hernad_ssh.key -o StrictHostKeyChecking=no root@files.bring.out.ba chown hernad /mnt/HD/HD_a2/bringout/Platform/linux32/PSQL_Platform*.zip
 
CMD ["bash"]
