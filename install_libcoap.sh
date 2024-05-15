#!/bin/bash

build_dir="$(pwd)/libcoap/build"
install_mode="default"

git clone https://github.com/obgm/libcoap
cd libcoap

if [ "$install_mode" == "default" ]; then
    echo "Using cmake...."
    mkdir -p $build_dir
    cd $build_dir
    cmake -DENABLE_DTLS=ON -DDTLS_BACKEND=openssl -DENABLE_DOCS=OFF ..
else
    echo "Using autogen.sh...."
    ./autogen.sh
    ./configure --enable-dtls --with-openssl --disable-manpages --disable-doxygen --enable-tests
fi

# Build and install
make
sudo make install

echo "---------------------------------"
echo "If sucessful, libcoap should be installed in /usr/local/lib"
echo "---------------------------------"