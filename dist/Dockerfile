FROM nginx:1.19.2-alpine

LABEL maintainer="noitran.black@gmail.com"

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

ENV PHP_UPSTREAM_CONTAINER=app
ENV PHP_UPSTREAM_PORT=9000

RUN set -x; \
    addgroup -g 82 -S www-data; \
    adduser -u 82 -D -S -G www-data www-data;

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY host.conf /etc/nginx/conf.d/default.conf

RUN set -eux; \
    mkdir -p /app/public; \
    cp /usr/share/nginx/html/index.html /app/public/; \
    chmod +x /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx"]

EXPOSE 80 443
