# Shibboleth Install 
```
sudo yum update -y
sudo yum install vim httpd php php-devel php-gd php-imap php-ldap php-mysql php-odbc php-pear php-xml php-xmlrpc curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel -y 
curl http://download.opensuse.org/repositories/security:/shibboleth/CentOS_7/security:shibboleth.repo > /etc/yum.repos.d/shibboleth.repo
yum install shibboleth -y
service shibd start 
```

### Get GE IDP Metadata 
TO DO
For now, just SFTPd if - host on an open webserver

### Edit the shibboleth.xml file 
`<MetadataProvider type="XML" file="GEasIDPmetadatastg.xml"/>`
`<SSO entityID="gefssstg">SAML2 SAML1</SSO>`
`<ApplicationDefaults entityID="your-entitiy-id" REMOTE_USER="eppn persistent-id targeted-id">`

### Other

If your Linux OS is running SELinux,you will need to apply a policy package to allow Apache to communicate with the Shibboleth daemon.
To determine if your OS is running SELinux,execute the command ‘sestatus’.  
If you receive a response similar to the following, you are running SELinux
```
SELinux status:enabled
SELinuxfs mount:/selinux
Current mode:enforcing
Mode from config file:enforcing
Policy version:24
Policy from config file:targeted
```
#### allowHttpd2Shib.pp
sudo semodule -i allowHttpd2Shib.pp