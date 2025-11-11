# Build stagee
FROM golang:1.25-alpine AS builder
WORKDIR /app
COPY apps/go_server/ ./apps/go_server/
WORKDIR /app/apps/go_server

RUN go mod tidy && \
    go build -o /app/server .

# Final image
FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app/server /app/server
EXPOSE 8080

# Create a non-root user and switch to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD echo " Starting container.." && \
    echo "Contents of /app:" && ls -lh /app && \
    echo "File info:" && file /app/server && \
    echo " Launching Go server.." && \
    /app/server || (echo "️ Server crashed unexpectedly"; sleep 60)
    
