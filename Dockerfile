# Name of the image it is based
FROM python:3.7-alpine

# Company who maintains that image
# MAINTAINER Alejandro Suau

# Creates this ENV variables and sets it to 1.
# which means that Docker won't buffer the output from your application
ENV PYTHONUNBUFFERED 1

# Install our dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Create the directory where we will store our applications code
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create a user who will execute our application (-D run applications only)
RUN adduser -D user
# Switch to that user
USER user
