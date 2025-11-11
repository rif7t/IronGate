FROM golang:1.25 AS builder

WORKDIR /app 
COPY apps/go_server/ ./apps/go_server/  
WORKDIR /app/apps/go_server 

RUN go mod tidy && \
    go build -o /app/server .


FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app/server /app/server
EXPOSE 8080

# Create a non-root user and switch to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD /app/server 





