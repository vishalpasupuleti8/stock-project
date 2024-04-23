# Use a Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install dependencies including Flask, Gunicorn, and requests
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose port 5000
EXPOSE 5000

# Command to run the application with Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "polygon:app"]
