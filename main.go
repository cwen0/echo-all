package main

import (
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"
)

type requestLogger struct{}

func (rl requestLogger) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	var bodyBytes []byte
	var err error

	if r.Body != nil {
		bodyBytes, err = ioutil.ReadAll(r.Body)
		if err != nil {
			fmt.Printf("Body reading error: %v", err)
			return
		}
		defer r.Body.Close()
	}
	fmt.Printf("Headers: %+v\n", r.Header)

	if len(bodyBytes) > 0 {
		var prettyJSON bytes.Buffer
		if err = json.Indent(&prettyJSON, bodyBytes, "", "\t"); err != nil {
			fmt.Printf("JSON parse error: %v", err)
			return
		}
		fmt.Println(string(prettyJSON.Bytes()))
	} else {
		fmt.Printf("Body: No Body Supplied\n")
	}
}

func main() {
	var port int
	flag.IntVar(&port, "port", 8082, "Port to listen on")

	fmt.Printf("Starting request echo server on port %v\n", port)
	err := http.ListenAndServe(fmt.Sprintf("0.0.0.0:%v", port), requestLogger{})
	fmt.Printf("Server error: %v\n", err)
}
