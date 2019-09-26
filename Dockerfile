FROM python:3.4

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi 
RUN cd /tmp &&\
    curl http://download.redis.io/redis-stable.tar.gz | tar xz &&\
    make -C redis-stable &&\
    cp redis-stable/src/redis-cli /usr/local/bin &&\
    rm -rf /tmp/redis-stable
RUN pip install Flask uWSGI requests redis
WORKDIR /app
COPY app /app
COPY cmd.sh /
RUN chmod +x /cmd.sh
EXPOSE 9090 9191
USER uwsgi

CMD ["/cmd.sh"]