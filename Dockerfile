FROM centos:7

USER root
RUN yum --setopt=tsflags=nodocs install -y gcc make autoconf apr-devel apr-util-devel libcurl libnghttp2 openssl-devel pcre-devel gzip tar wget \
    && yum clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum \
    && mkdir /tmp/output
COPY build-apache.sh /tmp
WORKDIR /tmp
CMD ["/tmp/build-apache.sh"]
