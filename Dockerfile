FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o server .

# Final image
FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app/server .

# Create a non-root user and switch to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD echo "-> Starting container" && \
    echo "Contents of /app:" && ls -lh /app && \
    echo "File info:" && file /app/server && \
    echo "-> Launching Go server " && \
    /app/server || (echo "Server crashed unexpectedly"; sleep 60)
