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
FROM golang:1.25 AS builder

# Set working directory
WORKDIR /build

# Copy your Go server folder
COPY apps/go_server/ .

# Download dependencies
RUN go mod tidy

# Build the Go binary
RUN go build -o server .

# ---- Run stage ----
FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=builder /build/server .

EXPOSE 8000

CMD ["./server"]


