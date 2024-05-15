# libcoap-proxy

This is a fork of [https://github.com/Rodriferli/libcoap-proxy-TFG](https://github.com/Rodriferli/libcoap-proxy-TFG).

## Install the project

### libcoap

The proxy works with libcoap latest version

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

And then run the coap client. For example

```bash
.<path_to_coap_client>/coap-client -P coap://[::1] -m get http://localhost:8080
```

will send a GET request to the HTTP server at `localhost:8080` through the proxy.
