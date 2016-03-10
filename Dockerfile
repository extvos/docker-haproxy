FROM extvos/centos
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV HAPROXY_VERSION 1.5.14.Rev1

VOLUME /etc/haproxy 

RUN yum install -y /sbin/service  \
    && rpm -Uvh https://github.com/extvos/rpmbuild/raw/master/RPMS/x86_64/haproxy-1.5.14.Rev1-1.el6.x86_64.rpm \
    && mkdir -p /var/run/haproxy/ && mkdir -p /usr/local/share/haproxy 

CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
