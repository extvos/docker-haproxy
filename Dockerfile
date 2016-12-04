FROM extvos/centos
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV HAPROXY_VERSION 1.6.9.Rev2

VOLUME /etc/haproxy 
VOLUME /var/log

COPY docker-entrypoint.sh /

RUN /usr/bin/yum install -y /sbin/service  \
    && /bin/rpm -Uvh https://github.com/extvos/rpmbuild/raw/master/RPMS/x86_64/haproxy-1.6.9.rev2-1.el6.x86_64.rpm \
    && /usr/bin/yum install -y rsyslog logrotate crontabs \
    && /bin/sed -i 's/#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf \
    && /bin/sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf \
    && /bin/chmod +x /docker-entrypoint.sh \
    && /bin/mkdir -p /var/run/haproxy/ && /bin/mkdir -p /usr/local/share/haproxy 

COPY syslog.logrotate.conf /etc/logrotate.d/syslog

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
