# Use the official Python 3 slim image as the base image
FROM python:3-slim

# Expose port 5001 for the application
EXPOSE 5001

# Disable the creation of .pyc files and unbuffer Python logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

# Set the working directory in the container
WORKDIR /app

# Copy all project files to the container
COPY . /app

# Create a non-root user and assign permissions to /app
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app

# Use the non-root user
USER appuser

# Default command to run the application with Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5001", "app:app"]
# Gunicorn to listen on 5001 by default
