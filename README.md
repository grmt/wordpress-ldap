# wordpress-ldap

Stock [WordPress](https://hub.docker.com/_/wordpress) image (`fpm-alpine` /
`cli` variants) plus PHP's `ldap` extension, for WordPress sites that
authenticate against an LDAP/OpenLDAP directory instead of a plugin-local
user table.

Built daily (and on every `Dockerfile` change) by
[`.github/workflows/build.yml`](.github/workflows/build.yml), always with
`--pull`, and pushed to GHCR. The PHP version is a single `PHP_VERSION`
line at the top of that workflow -- bump it there to move both variants:

- `ghcr.io/grmt/wordpress-ldap-public:fpm-alpine`
- `ghcr.io/grmt/wordpress-ldap-public:cli`

This keeps the image current with upstream WordPress/PHP security fixes
without anyone having to remember to rebuild it by hand.
