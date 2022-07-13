FROM ubuntu:latest

RUN apt update 
RUN apt install sqlite3 -y
RUN apt install gawk -y

RUN mkdir /nginx-db
RUN sqlite3 /nginx-db/logs.db "create table todo (ip TEXT, timestamp TEXT, status_code TEXT, bytes_sent TEXT, request_method TEXT, request_url TEXT,  request_protocol TEXT, referrer TEXT, user_agent TEXT, host TEXT);"


