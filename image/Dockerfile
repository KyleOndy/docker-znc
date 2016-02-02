FROM gliderlabs/alpine:3.3
MAINTAINER Kyle Ondy <kyle@ondy.me>

RUN apk add --no-cache \
      build-base \
      curl \
      openssl-dev \
      znc \
      znc-dev

ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default /znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /znc-data

EXPOSE 6667
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
