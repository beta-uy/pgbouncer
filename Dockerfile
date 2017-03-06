FROM alpine:latest

RUN apk add --no-cache ca-certificates wget alpine-sdk libevent-dev openssl-dev

RUN wget https://pgbouncer.github.io/downloads/files/1.7.2/pgbouncer-1.7.2.tar.gz \
 && tar -vxzf pgbouncer-1.7.2.tar.gz

RUN cd pgbouncer-1.7.2 && ./configure --prefix=/usr/local && make && make install
RUN rm /pgbouncer-1.7.2.tar.gz

RUN adduser -S -D pgbouncer

RUN mkdir -p /etc/pgbouncer/templates
RUN chown pgbouncer /etc/pgbouncer
COPY ./templates/ /etc/pgbouncer/templates
COPY entrypoint.sh render_templates.py /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pgbouncer", "/etc/pgbouncer/pgbouncer.ini", "-u", "pgbouncer"]