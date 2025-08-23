# Use an official lightweight Python image
FROM python:3.11-slim

# Set a working directory inside the container
WORKDIR /app

# Copy dependency list first (better for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy your actual app code
COPY testapp.py

# Expose port (FastAPI default is 8000)
EXPOSE 8000

# Run the app with uvicorn (for FastAPI/Flask)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
