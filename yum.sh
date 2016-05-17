#!/bin/bash

# cat yum.install.sh  | sed -e 's/-[0-9].\+//g' | sort -u

echo 'multilib_policy=all' >> /etc/yum.conf

softs='binutils
compat-libcap1
compat-libstdc++
gcc
gcc-c++
glibc
glibc-devel
ksh
libaio
libaio-devel
libgcc
libstdc++
libstdc++-devel
make
sysstat
unixODBC
unixODBC-devel'

for soft in $softs
do
  yum install -y $soft*
done
