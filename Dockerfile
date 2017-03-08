FROM debian:jessie

# Using c-ares: https://pgbouncer.github.io/install.html#dns-lookup-support
# to solve: http://lists.pgfoundry.org/pipermail/pgbouncer-general/2012-September/001038.html

# via https://github.com/pgbouncer/pgbouncer/issues/122#issuecomment-199182461 
# Install build deps, build and cleanup in one shot
RUN apt-get update \
    && apt-get -y --no-install-recommends install \ 
        automake \
        build-essential \
        ca-certificates \
        git \
        libc-ares2 \
        libc-ares-dev \
        libev4 \
        libev-dev \
        libevent-2.0-5 \
        libevent-dev \
        libssl1.0.0 \
        libssl-dev \
        libtool \
        pkg-config \
        python \
        wget \
    && mkdir -p /opt && cd /opt \
    && git clone https://github.com/pgbouncer/pgbouncer.git \
    && cd /opt/pgbouncer \
    && git checkout pgbouncer_1_7_2 \
    && git submodule init \
    && git submodule update \
    && ./autogen.sh \
    && ./configure --enable-evdns=no \
    && make \
    && make install \
    && apt-get remove -y \
        automake \
        build-essential \
        ca-certificates \
        git \
        libc-ares-dev \
        libev-dev \
        libevent-dev \
        libssl-dev \
        libtool \
        pkg-config \
        wget \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN adduser --system --disabled-password pgbouncer

RUN mkdir -p /etc/pgbouncer/templates
RUN chown pgbouncer /etc/pgbouncer
COPY ./templates/ /etc/pgbouncer/templates
COPY entrypoint.sh render_templates.py /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pgbouncer", "/etc/pgbouncer/pgbouncer.ini", "-u", "pgbouncer"]