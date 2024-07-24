# libcoap-proxy

This is a fork of [https://github.com/Rodriferli/libcoap-proxy-TFG](https://github.com/Rodriferli/libcoap-proxy-TFG).

## Install the project

## Prerequisites

If you want to use wolfSSL as DTLS backend and post-quantum cryptography, you need to install [liboqs](https://github.com/open-quantum-safe/liboqs) and [wolfSSL](https://github.com/wolfSSL/wolfssl) with post-quantum cryptography support:

```bash
./install_liboqs_for_wolfssl.sh
./install_wolfssl.sh
```

These scripts will install liboqs and configure wolfSSL with post-quantum cryptography support, including options for DTLS 1.3 and experimental features.

### libcoap

The proxy works with libcoap latest version

First install libcoap

```bash
./install_libcoap.sh [-b dtls_backend]
```

This script now allows you to specify the DTLS backend. By default, it uses wolfSSL. You can change this by using the `-b` option followed by the desired backend.
The script also sets up specific cryptographic groups. As an example, we show how to include the post-quantum algorithm `KYBER_LEVEL1`, alongside traditional elliptic curve groups `P-384` and `P-256`. This requires to have enabled PQ cryptography in the wolfSSL installation.

This will install libcoap in the `/usr/local/lib` directory.

### Proxy

Then install the proxy

```bash
./install_proxy.sh </path/to/libcoap>
```

## Running the proxy

First ensure the HTTP server is running. Then run the proxy with the following command

```bash
 ./build/coap2HttpServer -P ",my_proxy"
```

And then run the coap client. For example

```bash
.<path_to_coap_client>/coap-client -P coap://[::1] -m get http://localhost:8080
```

will send a GET request to the HTTP server at `localhost:8080` through the proxy.
