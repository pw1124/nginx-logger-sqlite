FROM ubuntu:latest

ENV TZ=America/Vancouver \
    APP_USER=appuser

RUN groupadd $APP_USER \
    && useradd -g $APP_USER $APP_USER \
    && mkdir /nginx_logger_script

WORKDIR /nginx_logger_script

COPY ./start-logging.sh ./

RUN chown $APP_USER:$APP_USER /nginx_logger_script

RUN apt update 
RUN apt install sqlite3 -y
RUN apt install gawk -y

RUN mkdir /nginx_db
RUN sqlite3 /nginx_db/logs.db "create table todo (ip TEXT, timestamp TEXT, status_code TEXT, bytes_sent TEXT, request_method TEXT, request_url TEXT,  request_protocol TEXT, referrer TEXT, user_agent TEXT, host TEXT);"

USER $APP_USER

CMD ["./start-logging.sh"]


