# Name of the image it is based
FROM python:3.7-alpine

# Company who maintains that image
# MAINTAINER Alejandro Suau

# Creates this ENV variables and sets it to 1.
# which means that Docker won't buffer the output from your application
ENV PYTHONUNBUFFERED 1

# Install our dependencies
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Create the directory where we will store our applications code
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create a user who will execute our application (-D run applications only)
RUN adduser -D user
# Switch to that user
USER user
