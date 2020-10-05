#!/bin/sh

set -ex

# Set upstream conf
echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf;

exec "$@"
