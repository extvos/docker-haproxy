FROM extvos/centos
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV HAPROXY_VERSION 1.5.14.Rev1

VOLUME /etc/haproxy 
VOLUME /var/log

COPY docker-entrypoint.sh /

RUN yum install -y /sbin/service  \
    && rpm -Uvh https://github.com/extvos/rpmbuild/raw/master/RPMS/x86_64/haproxy-1.5.14.Rev1-1.el6.x86_64.rpm \
    && yum install -y rsyslog \
    && sed -i 's/#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf \
    && sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf \
    && chmod +x /docker-entrypoint.sh \
    && mkdir -p /var/run/haproxy/ && mkdir -p /usr/local/share/haproxy 

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
