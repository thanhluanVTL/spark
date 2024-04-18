FROM python:3.9.5-buster

RUN apt-get update && apt-get install -y openjdk-11-jdk

COPY ./requirements.txt .

RUN pip install -r requirements.txt

WORKDIR /home/code