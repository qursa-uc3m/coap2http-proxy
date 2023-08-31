#include <stdio.h>
#include <curl/curl.h>

int main(void){
    CURL *curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_ALL);

    curl = curl_easy_init();
    if(curl){
        /*Custom headers to bypass schema restrictions*/
        struct curl_slist *chunk = NULL;

        /* Add a custom header*/
        chunk = curl_slist_append(chunk, "Dest-Uri: coap://[::1]/time");

        /* set our custom set of headers */
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, chunk);
        curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, "GET");
        curl_easy_setopt(curl, CURLOPT_URL, "http://localhost:8000");
        /*Para peticiones POST o PUT*/
        /*
        curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, 12L);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, "Mensaje 1");
         */

        res = curl_easy_perform(curl);

        if(res != CURLE_OK){
            fprintf(stderr, "curl_easy_perform() returned %s\n", curl_easy_strerror(res));
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();
    return 0;
}
