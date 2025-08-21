package main

import "fmt"
import "log"
import "net/http"

func health(w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "ok")
}

func main() {
    http.HandleFunc("/health", health)
    log.Println("hello-api listening on :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
