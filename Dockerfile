FROM debian:jessie

# via https://github.com/Kotaimen/docker-pgbouncer/blob/develop/Dockerfile
RUN set -x \
 && apt-get -qq update \
 && apt-get install -yq --no-install-recommends libevent-dev libudns-dev \
 && apt-get install -yq --no-install-recommends python pgbouncer \
 && apt-get purge -y --auto-remove \
 && rm -rf /var/lib/apt/lists/*

RUN adduser --system --disabled-password pgbouncer

RUN mkdir -p /etc/pgbouncer/templates
RUN chown pgbouncer /etc/pgbouncer
COPY ./templates/ /etc/pgbouncer/templates
COPY entrypoint.sh render_templates.py /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pgbouncer", "/etc/pgbouncer/pgbouncer.ini", "-u", "pgbouncer"]