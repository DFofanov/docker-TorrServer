#
# This is unofficial dockerized precompiled TorrServer
#
FROM ubuntu:latest
MAINTAINER DFofanov <dfofanov@gmail.com>

# On linux systems you need to set this environment variable before run:
ENV GODEBUG="madvdontneed=1"

ENV TorrSrv_RELEASE="1.1.77"
ENV TorrSrv_URL=https://github.com/YouROK/TorrServer/releases/download/$TorrSrv_RELEASE/TorrServer-linux-amd64
ENV TorrSrv_PORT="8090"

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update && apt-get upgrade -y \
&& apt-get install --no-install-recommends -y ca-certificates tzdata wget curl procps cron \
&& apt-get clean \
&& mkdir -p /torrserver/config && chmod -R 666 /torrserver/config \
&& wget -O TorrServer -P /torrserver/ $TorrSrv_URL \
&& chmod a+x /torrserver \
&& touch /var/log/cron.log \
&& ln -sf /proc/1/fd/1 /var/log/cron.log

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl -sS 127.0.0.1:$TorrSrv_PORT || exit 1

VOLUME [ "/torrserver/config" ]

EXPOSE "$TorrSrv_PORT"

ENTRYPOINT ["chmod +x /torrserver/TorrServer --path=/torrserver/config/ --port=$TorrSrv_PORT"]
CMD ["--path", "/torrserver/config"]