# Docker Image for Shib
# Set Base Image
FROM centos:7
MAINTAINER Patrick Lunney
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum install httpd php libxml2 shibboleth -y \
    yum clean all


# RUN firewall-cmd --permanent --zone=public --add-service=http
# RUN firewall-cmd --permanent --zone=public --add-service=https
# RUN firewall-cmd --reload

EXPOSE 80

COPY index.php                  /var/www/html
COPY shibboleth2.xml            /etc/shibboleth2
COPY fss_gecompany_com_IDP.xml  /etc/shibboleth2

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]