FROM extvos/centos
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV HAPROXY_VERSION 1.6.9.Rev2

VOLUME /etc/haproxy 
VOLUME /var/log

COPY docker-entrypoint.sh /

RUN yum install -y /sbin/service  
RUN rpm -Uvh https://github.com/extvos/rpmbuild/raw/master/RPMS/x86_64/haproxy-1.6.9.rev2-1.el6.x86_64.rpm 
RUN yum install -y rsyslog logrotate crontabs 
RUN sed -i 's/#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf 
RUN sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf 
RUN chmod +x /docker-entrypoint.sh 
RUN mkdir -p /var/run/haproxy/ && mkdir -p /usr/local/share/haproxy /usr/share/haproxy

COPY syslog.logrotate.conf /etc/logrotate.d/syslog

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
