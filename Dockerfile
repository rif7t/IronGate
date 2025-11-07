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
FROM golang:1.25 AS builder

WORKDIR /app

# Copy the go_server source
COPY apps/go_server/ ./apps/go_server/

# Move into that directory
WORKDIR /app/apps/go_server

# Download dependencies and build
RUN go mod tidy
RUN go build -o server .


FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/apps/go_server/server .
CMD ["./server"]



