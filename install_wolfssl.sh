#!/bin/bash
#
# install_wolfssl.sh — Build & install wolfSSL for the CoAP-to-HTTP proxy
#
# Environment variables (all optional):
#   WOLFSSL_VERSION   Tag to checkout  (default: v5.8.2-stable)
#   PQC_BACKEND       "builtin" | "liboqs" | "none"  (default: builtin)
#
# "builtin"  — uses wolfSSL's native ML-KEM (FIPS 203) + ML-DSA, no liboqs needed
# "liboqs"   — links against a pre-installed liboqs (legacy KYBER naming)
# "none"     — no post-quantum key exchange
#

set -e

WOLFSSL_VERSION="${WOLFSSL_VERSION:-v5.8.2-stable}"
PQC_BACKEND="${PQC_BACKEND:-builtin}"

apt-get update
apt-get install -y autoconf automake libtool coreutils bsdmainutils

git clone https://github.com/wolfSSL/wolfssl.git
cd wolfssl
git checkout "${WOLFSSL_VERSION}"
./autogen.sh

mkdir build
cd build

COMMON_FLAGS="--enable-all \
    --enable-dtls \
    --enable-dtls13 \
    --enable-experimental \
    --enable-dtls-frag-ch \
    --disable-rpk"

case "${PQC_BACKEND}" in
    builtin)
        echo ">>> wolfSSL ${WOLFSSL_VERSION}: built-in ML-KEM + ML-DSA (no liboqs)"
        ../configure ${COMMON_FLAGS} --enable-mlkem --enable-dilithium
        ;;
    liboqs)
        echo ">>> wolfSSL ${WOLFSSL_VERSION}: PQC via liboqs"
        ../configure ${COMMON_FLAGS} --with-liboqs
        ;;
    none)
        echo ">>> wolfSSL ${WOLFSSL_VERSION}: no PQC"
        ../configure ${COMMON_FLAGS}
        ;;
    *)
        echo "ERROR: unknown PQC_BACKEND='${PQC_BACKEND}' (use builtin|liboqs|none)" >&2
        exit 1
        ;;
esac

make all
make install
