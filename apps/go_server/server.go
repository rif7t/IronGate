package main

import (
	"fmt"
	"log"
	"net/http"
)

func health(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "ok")
}

func ping(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "pong")
}

func main() {
	http.HandleFunc("/ping", ping)
	http.HandleFunc("/Healthy", health)
	log.Println("Go Server printing at :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
