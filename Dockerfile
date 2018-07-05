# Docker Image for Shib
# Set Base Image
FROM ubuntu:16.04
MAINTAINER Patrick Lunney
LABEL Vendor="Ubuntu" \
      License=GPLv2 \
      Version=2.4.6-40

## Apply Proxies
ENV  http_proxy='http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80'
ENV  https_proxy='http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80'

RUN apt-get update -y
RUN apt-get install curl -y
RUN apt-get install apache2 -y 
RUN apt-get install libapache2-mod-shib2 -y
RUN apt-get install php libapache2-mod-php php-mcrypt php-mysql -y

EXPOSE 80

COPY index.php                  /var/www/html
COPY shibboleth2.xml            /etc/shibboleth
COPY fss_gecompany_com_IDP.xml  /etc/shibboleth
COPY attribute-map.xml          /etc/shibboleth
COPY testappsaml.conf           /etc/apache2/sites-enabled

RUN rm /var/www/html/index.html
RUN openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 -subj "/CN=$HOSTNAME" -keyout /etc/shibboleth/sp-key.pem -out /etc/shibboleth/sp-cert.pem

RUN shibd -t
RUN apache2ctl configtest

COPY run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh
ENTRYPOINT ["/usr/bin/run.sh"] 