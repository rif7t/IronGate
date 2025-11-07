# Use an official lightweight Python image
#FROM python:3.11-slim

# Set a working directory inside the container
#WORKDIR /app

# Copy dependency list first (better for caching)
#COPY requirements.txt .

# Install dependencies
#RUN pip install --no-cache-dir -r requirements.txt

# Copy your actual app code
#COPY . .

# Expose port (FastAPI default is 8000)
#EXPOSE 8000

# Run the app with uvicorn (for FastAPI/Flask)
#CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
# syntax=docker/dockerfile:1
# ----------- Build Stage -----------
FROM golang:1.25 AS builder

WORKDIR /app

COPY apps/go_server/ ./apps/go_server/
WORKDIR /app/apps/go_server

RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .

# ----------- Runtime Stage -----------
FROM ubuntu:24.04

WORKDIR /app

COPY --from=builder /app/apps/go_server/server .

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       curl \
       netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

HEALTHCHECK CMD curl -f http://localhost:8080/Healthy || exit 1

CMD ["./server"]





