# Use an official Python image
FROM python:3.12-slim

# Prevent Python from writing pyc files and buffering stdout
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Copy project files into container
COPY . /app/

# Install pip and set timeout to avoid download errors
RUN pip install --upgrade pip
RUN pip install --default-timeout=100 --no-cache-dir -r exam_portal_project/requirements.txt

# Expose port 8000
EXPOSE 8000

# Run Django server
CMD ["python", "exam_portal_project/exam_portal/manage.py", "runserver", "0.0.0.0:8000"]
