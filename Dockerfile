# Base image for Azure Functions with Python 3.9
# Alternative base image for enabling SSH & remote debugging:
# FROM mcr.microsoft.com/azure-functions/python:4-python3.9-appservice
FROM --platform=linux/arm64/v8 mcr.microsoft.com/azure-functions/python:4-python3.9

# Environment variables for Azure Functions configurations
ENV AzureWebJobs_FileWatchingEnabled=false \
    AzureFunctionsWebHost__IsFileSystemReadOnly=True \
    AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

# Copy the requirements.txt file to the container
COPY requirements.txt /

# Install Python dependencies specified in requirements.txt
RUN pip install -r /requirements.txt

# Copy the application code to the specified directory in the container
COPY . /home/site/wwwroot