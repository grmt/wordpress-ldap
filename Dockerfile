# Stock WordPress image plus PHP's ldap extension, for sites that need
# WordPress talking to an LDAP/OpenLDAP directory backend instead of a
# plugin-local user table.
#
# Rebuilt daily by .github/workflows/build.yml and pushed to GHCR, so
# consumers just pull ghcr.io/grmt/wordpress-ldap-public:fpm-alpine /
# :cli and get upstream WordPress/PHP security fixes automatically.
#
# BASE selects the flavour (wordpress:php8.4-fpm-alpine for the site,
# wordpress:cli-php8.4 for the wpcli-* helpers); RUNTIME_USER restores the
# base image's own user afterwards (root for fpm, www-data for the cli
# image), since compiling the extension needs root.
ARG BASE=wordpress:php8.4-fpm-alpine
FROM ${BASE}
ARG RUNTIME_USER=root

USER root
RUN apk add --no-cache --virtual .ldap-build $PHPIZE_DEPS openldap-dev \
 && docker-php-ext-install -j"$(nproc)" ldap \
 && apk add --no-cache libldap \
 && apk del .ldap-build \
 && php -m | grep -qx ldap
USER ${RUNTIME_USER}
