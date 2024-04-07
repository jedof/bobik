FROM python:3.11-slim-bullseye 

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ADD requirements.txt requirements.txt
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY helpers ./helpers
COPY *.py ./
COPY *.sql ./
COPY db ./db
