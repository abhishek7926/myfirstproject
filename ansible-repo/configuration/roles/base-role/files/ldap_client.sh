#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y install libpam-ldap nscd ldap-utils libnss-ldapd
mv /etc/ldap.conf /etc/ldap.conf-orig
echo "base dc=mettl,dc={{ internal_domain }}" > /etc/ldap.conf
echo "uri ldapi://ldap.mettl.{{ internal_domain }}/" >> /etc/ldap.conf
echo "ldap_version 3" >> /etc/ldap.conf
echo "pam_filter objectclass=account" >> /etc/ldap.conf
echo "pam_check_host_attr yes" >> /etc/ldap.conf
echo "pam_password md5" >> /etc/ldap.conf
mv /etc/nslcd.conf /etc/nslcd.conf-orig
echo "uid nslcd" > /etc/nslcd.conf
echo "gid nslcd" >> /etc/nslcd.conf
echo "uri ldap://ldap.mettl.{{ internal_domain }}/" >> /etc/nslcd.conf
echo "base dc=mettl,dc={{ internal_domain }}" >> /etc/nslcd.conf
echo "pam_authz_search (&(objectClass=posixAccount)(uid=$username)(|(host=$hostname)(!(host=*))))" >> /etc/nslcd.conf
sed -i -r 's/(^passwd:)(\s+)(.*)/\1\2compat ldap/' /etc/nsswitch.conf
sed -i -r 's/(^group:)(\s+)(.*)/\1\2compat ldap/' /etc/nsswitch.conf
sed -i -r 's/(^shadow:)(\s+)(.*)/\1\2compat ldap/' /etc/nsswitch.conf
service nscd restart
service nslcd restart
apt-get -y install autofs
echo "/ldaphome /etc/home.map" >> /etc/auto.master
echo "* -fstype=nfs,rw,nosuid,soft ldap.mettl.{{ internal_domain }}:/ldaphome/&" > /etc/home.map
service autofs restart