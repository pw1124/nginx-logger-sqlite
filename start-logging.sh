#!/bin/sh

echo "Start logging..."

tail -f /nginx_logs/formetabase.log | \
gawk '{print  $1  " " substr($4, 2, length($4) - 8) " " $6 " " $7 " " substr($5, 2, length($5) -2)  " " substr($8, 2, length($8)-2) " " substr($9, 2, length($9)-2) " " $10; system("")}' FPAT='[^ ]*|"[^"]*"|\\[[^]]*\\]' | \
(while read ip timestamp status_code bytes_sent request_method request_url request_protocol referrer host user_agent; do sqlite3 -batch /nginx_db/logs.db "insert into todo (ip, timestamp, status_code, bytes_sent, request_method, request_url, request_protocol, referrer, host, user_agent) values (\"$ip\",\"$timestamp\", \"$status_code\", \"$bytes_sent\", \"$request_method\", \"$request_url\", \"$request_protocol\" ,\"$referrer\" , \"$host\", $user_agent );"; done )

