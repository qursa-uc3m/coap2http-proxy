#!/bin/bash
#
# install_libcoap.sh — Build & install libcoap with wolfSSL DTLS backend
#
# Environment variables (all optional):
#   WOLFSSL_GROUPS  Colon-separated TLS 1.3 named groups
#                   (default: P-256:P-384:X25519:ML_KEM_512:ML_KEM_768:ML_KEM_1024)
#   DTLS_BACKEND    "wolfssl" | "openssl"  (default: wolfssl)
#

set -e

WOLFSSL_GROUPS="${WOLFSSL_GROUPS:-P-256:P-384:X25519:ML_KEM_512:ML_KEM_768:ML_KEM_1024}"
DTLS_BACKEND="${DTLS_BACKEND:-wolfssl}"
LIBCOAP_VERSION="${LIBCOAP_VERSION:-v4.3.5}"

git clone https://github.com/obgm/libcoap
cd libcoap
git checkout "${LIBCOAP_VERSION}"

# Fix: wolfSSL 5.8.2 --enable-all enables DTLS CID, which triggers a
# compile-time #bad directive in coap_wolfssl.c when CID length exceeds
# the internal max.  Comment it out — CID is not used by the proxy.
sed -i 's/^#bad .*DTLS_CID.*$/\/\* CID size check disabled for wolfSSL 5.8.2 \*\//' src/coap_wolfssl.c 2>/dev/null || true

echo ">>> libcoap: DTLS_BACKEND=${DTLS_BACKEND}, WOLFSSL_GROUPS=${WOLFSSL_GROUPS}"
mkdir -p build && cd build
CFLAGS="-DCOAP_WOLFSSL_GROUPS=\"\\\"${WOLFSSL_GROUPS}\\\"\"" \
    cmake -DENABLE_DTLS=ON -DDTLS_BACKEND="${DTLS_BACKEND}" -DENABLE_DOCS=OFF ..

make
make install

echo "---------------------------------"
echo "libcoap installed to /usr/local/lib"
echo "---------------------------------"