# Use Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy app files
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

# Command to run the app
CMD ["python", "app.py"]

