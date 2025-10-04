FROM chinachu/mirakurun:latest

ENV DEV="git autoconf automake cmake libtool"

RUN apt update && \
apt upgrade -y && \
apt -y install $DEV && \

cd /tmp && \
git clone https://github.com/tsunoda14/libyakisoba.git && \
cd libyakisoba && \
autoreconf -i && \
mkdir build && \
cd build && \
../configure --sysconfdir=/usr/local/etc && \
make && \
make install && \

cd /tmp && \
git clone https://github.com/tsunoda14/libsobacas.git && \
cd libsobacas && \
autoreconf -i && \
mkdir build && \
cd build && \
../configure --sysconfdir=/usr/local/etc && \
make && \
make install && \

cd /tmp && \
git clone https://github.com/tsukumijima/libaribb25.git && \
cd libaribb25 && \
cmake -DWITH_PCSC_PACKAGE=NO -DWITH_PCSC_LIBRARY=sobacas -B build && \
cd build && \
make && \
make install && \

cd /tmp && \
git clone https://github.com/stz2012/recpt1.git && \
cd recpt1/recpt1 && \
./autogen.sh && \
./configure && \
make && \
make install

apt remove -y $DEV && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*
