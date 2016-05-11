FROM debian:jessie

MAINTAINER Alexander.Schrapel@zarambo.de

RUN apt-get -q -y update \
    && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
    && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install wget \
    && wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb \
    && dpkg -i puppetlabs-release-pc1-jessie.deb \
    && apt-get update \
    && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install puppetserver \
    && apt-get -q -y autoremove \
    && apt-get -q -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm puppetlabs-release-pc1-jessie.deb

COPY util/entrypoint.sh /entrypoint.sh

VOLUME ["/etc/puppetlabs/code", "/etc/puppetlabs/puppet/ssl"]

EXPOSE 8140

ENTRYPOINT ["/entrypoint.sh"]


