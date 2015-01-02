#!/bin/bash

SSH_OPTS="-i /root/hernad_ssh.key -o StrictHostKeyChecking=no"
 
scp $SSH_OPTS HB_Platform*.zip root@files.bring.out.ba:/mnt/HD/HD_a2/bringout/Platform/linux32
ssh $SSH_OPTS root@files.bring.out.ba chown hernad /mnt/HD/HD_a2/bringout/Platform/linux32/HB_Platform*.zip
 
