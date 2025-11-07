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
# ---- Build stage ----
FROM golang:1.25 AS builder

WORKDIR /app
COPY apps/go_server/ ./apps/go_server/
WORKDIR /app/apps/go_server

# Force Linux amd64 build to avoid arch mismatch
RUN GOOS=linux GOARCH=amd64 go mod tidy && go build -o /server .

# ---- Run stage ----
FROM ubuntu:24.04

WORKDIR /app
COPY --from=builder /server .

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       curl \
       ca-certificates \
       netcat-openbsd \
    && chmod +x /app/server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

# Add diagnostics
CMD echo "Starting Go server..." && ls -lh /app && file /app/server && ./server





