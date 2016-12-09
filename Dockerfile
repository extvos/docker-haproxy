FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV HAPROXY_VERSION 1.6.9.Rev2

VOLUME /etc/haproxy 
VOLUME /var/log

COPY docker-entrypoint.sh /
COPY packages/* /tmp

RUN apk update && apk add --allow-untrusted /tmp/haproxy-* && apk add rsyslog && rm -f /tmp/haproxy-*

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
