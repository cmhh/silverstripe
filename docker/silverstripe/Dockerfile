FROM ubuntu:24.04

ARG PHP_VERSION=8.3.15
ARG NGINX_VERSION=1.27.3

RUN apt-get update && \
  apt-get --no-install-recommends -y install \
    curl ca-certificates \
    build-essential autoconf libtool bison re2c pkg-config libxml2-dev libsqlite3-dev \
    libssl-dev libcurl4-openssl-dev libzip-dev libpng-dev libjpeg-dev libwebp-dev libavif-dev \
    libpq-dev libonig-dev libicu-dev \
    libpcre2-dev libssl-dev zlib1g-dev \
    supervisor
  
RUN cd /usr/local/src && \
  curl -sL \
    https://github.com/php/php-src/archive/refs/tags/php-${PHP_VERSION}.tar.gz \
    -o php.tar.gz && \
  tar -xvf php.tar.gz && \
  cd php-src-php-${PHP_VERSION} && \
  ./buildconf --force && \
  ./configure \
    --prefix=/opt/php \
    --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data \
    --with-openssl --with-curl \
    --with-zip --with-zlib \
    --enable-mbstring --enable-intl \
    --enable-gd --with-jpeg --with-webp --with-avif \
    --with-pdo-mysql --with-mysqli \
    --with-pdo-pgsql && \
  make -j12 && \
  make install && \
  rm -fR /opt/php/etc/*.default /opt/bin/etc/php-fpm.d/*.default && \
  rm -fR /usr/local/src/php*

RUN cd /usr/local/src && \
  curl -s https://getcomposer.org/installer -o installer.php && \  
  /opt/php/bin/php installer.php --install-dir=/usr/local/bin --filename=composer && \
  rm -fR /usr/local/src/composer.php

RUN cd /usr/local/src && \
  curl \
    -sL https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    -o nginx.tar.gz && \
  tar -xvf nginx.tar.gz && \
  cd nginx-${NGINX_VERSION} && \
  ./configure \
    --prefix=/opt/nginx \
    --user=www-data --group=www-data \
    --with-http_ssl_module \
    --with-stream \
    --with-mail=dynamic \
    --with-threads && \
  make -j12 && \
  make install  && \
  mkdir -p /opt/nginx/conf/nginx.conf.d && \
  rm /opt/nginx/conf/*.default && \
  rm -fR /usr/local/src/nginx*

RUN ln -s /opt/php/bin/php /usr/local/bin/php && \
  ln -s /opt/php/sbin/php-fpm /usr/local/bin/php-fpm && \
  ln -s /opt/nginx/sbin/nginx /usr/local/bin/nginx
  
COPY conf/php/php.ini /opt/php/lib/php.ini
COPY conf/php/php-fpm.conf /opt/php/etc/php-fpm.d/php-fpm.conf
COPY conf/nginx/nginx.conf /opt/nginx/conf/nginx.conf
COPY conf/nginx/silverstripe.conf /opt/nginx/conf/nginx.conf.d/silverstripe.conf
COPY conf/supervisor/silverstripe.conf /etc/supervisor/conf.d/silverstripe.conf

EXPOSE 80 443

CMD ["/usr/bin/supervisord", "-n"]