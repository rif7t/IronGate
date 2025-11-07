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
# ---- Build Stage ----
FROM golang:1.25 AS builder

WORKDIR /app

# Copy only your Go app
COPY apps/go_server/ ./apps/go_server/
WORKDIR /app/apps/go_server

# Download dependencies and build
RUN go mod tidy && \
    go build -o /app/server .

# ---- Run Stage ----
FROM ubuntu:22.04

# Install simple debugging tools
RUN apt-get update && \
    apt-get install -y curl netcat file && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /app/server /app/server
EXPOSE 8080

# Debug: print directory contents before running
CMD echo "===> Starting container..." && \
    echo "Contents of /app:" && ls -lh /app && \
    echo "File info:" && file /app/server && \
    echo "===> Launching Go server..." && \
    /app/server || (echo "⚠️ Server crashed unexpectedly"; sleep 60)






