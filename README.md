# libcoap-proxy

This is a fork of [https://github.com/Rodriferli/libcoap-proxy-TFG](https://github.com/Rodriferli/libcoap-proxy-TFG).

## Install the project

### libcoap

The proxy works with libcoap v4.3.1

First install libcoap

```bash
./install_libcoap.sh
```

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

And then run the coap client

```bash
.<path_to_coap_client>/coap-client -P coap://[::1] -m get http://127.0.0.1:6065/random_number/5
```
