FROM ubuntu:latest

ENV TZ=America/Vancouver \
    APP_USER=appuser

RUN useradd -g users -u 1000 $APP_USER 
RUN mkdir /nginx_db 

WORKDIR /nginx_logger_script

COPY ./start-logging.sh ./

RUN chown -R $APP_USER:users /nginx_logger_script
RUN chown -R $APP_USER:users /nginx_db

RUN apt update 
RUN apt install sqlite3 -y
RUN apt install gawk -y

RUN sqlite3 /nginx_db/logs.db "create table todo (ip TEXT, timestamp TEXT, status_code TEXT, bytes_sent TEXT, request_method TEXT, request_url TEXT,  request_protocol TEXT, referrer TEXT, user_agent TEXT, host TEXT);"

USER $APP_USER

CMD ["bash", "/nginx_logger_script/start-logging.sh"]


