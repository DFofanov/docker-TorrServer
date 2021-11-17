FROM alpine:latest
LABEL maintainer="dfofanov@gmail.com"

ENV GODEBUG="madvdontneed=1"

ENV RELEASE="1.1.77"
ENV URL=https://github.com/YouROK/TorrServer/releases/download/${RELEASE}/TorrServer-linux-amd64

WORKDIR /torrserver

VOLUME [/torrserver/config]
EXPOSE 8090

RUN export BACKEND=noninteractive \ 
&& apk add --no-cache wget curl \
&& mkdir -p ./config && chmod -R 775 ./config \
&& wget -O ./TorrServer -P ./ ${URL} \
&& chmod a+x TorrServer \
&& touch /var/log/cron.log \
&& ln -sf /proc/1/fd/1 /var/log/cron.log

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl -sS 127.0.0.1:${PORT} || exit 1

ENTRYPOINT ["./TorrServer"]
CMD ["--path", "./config"]