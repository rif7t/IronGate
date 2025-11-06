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
# ---- Build stage ----
FROM golang:1.22 AS builder

# Set working directory
WORKDIR /app

# Copy your Go server source
COPY apps/go_server/ .

# Download dependencies
RUN go mod tidy

# Build the Go binary
RUN go build -o server .

# ---- Run stage ----
FROM gcr.io/distroless/base-debian12

# Set working directory inside the container
WORKDIR /app

# Copy the built binary from builder
COPY --from=builder /app/server .

# Expose your server port
EXPOSE 8000

# Run the compiled Go binary
CMD ["./server"]


