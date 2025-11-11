FROM golang:1.25 AS builder

WORKDIR /app 

# Copy only Go app
COPY apps/go_server/ ./apps/go_server/  
WORKDIR /app/apps/go_server 


RUN go mod tidy && \
    go build -o /app/server .


FROM ubuntu:22.04

# Install simple debugging tools
RUN apt-get update && \
    apt-get install -y curl netcat file && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /app/server /app/server
EXPOSE 8080

CMD echo "===> Starting container..." && \
    echo "Contents of /app:" && ls -lh /app && \
    echo "File info:" && file /app/server && \
    echo "===> Launching Go server..." && \
    /app/server || (echo "️ Server crashed unexpectedly"; sleep 60) \
    --user $(id -u):$(id -g)






