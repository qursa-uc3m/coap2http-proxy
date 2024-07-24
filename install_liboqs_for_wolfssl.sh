#!/bin/bash

# SEE: https://github.com/wolfSSL/wolfssl/blob/master/INSTALL

# Dir for the current script
current_dir=$(pwd)
echo "Current dir: $current_dir"
liboqs_target_dir="/opt/liboqs"

# Prompt user for removal of existing installation
read -p "Do you want to remove existing installation? (y/n): " remove_existing
if [ "$remove_existing" == "y" ]; then
    echo "Removing existing installation..."
    
    rm -rf /usr/local/include/oqs
    rm -f /usr/local/lib/liboqs.a
    rm -rf ${liboqs_target_dir}
fi

echo "Cloning liboqs..."

mkdir -p ${liboqs_target_dir}
cd ${liboqs_target_dir}
git clone --single-branch https://github.com/open-quantum-safe/liboqs.git
cd liboqs/
git checkout 0.8.0

mkdir build
cd build
cmake -DOQS_USE_OPENSSL=0 ..
make all
make install
