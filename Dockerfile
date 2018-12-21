FROM alpine:3.8
MAINTAINER DylanWu

LABEL promvps_version="r801" architecture="amd64"

ENV DOMAIN=
ENV PORT_80=80
ENV PORT_443=443
ENV EMAIL=
ENV USER=
ENV PASSWORD=
ENV USE_SAMPLE=true
ENV BACKEND=file:///var/www/html
ENV ALLOW_EMPTY_SNI=true
ENV HTTP_MODE=http2
ENV DNS_SERVER=
ENV HOSTS_FILE=
ENV IPV6=true

EXPOSE 80 443

RUN apk add --no-cache git tar curl unzip

RUN curl https://raw.githubusercontent.com/wuzhongyi1105/goproxy/master/binary.zip -O \
    | mkdir /usr/bin/promvps \
    | unzip binary.zip -d /usr/bin/promvps \
 && chmod 0755 /usr/bin/promvps/promvps

VOLUME /var/www/html
VOLUME /etc/config
VOLUME /etc/certs

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
