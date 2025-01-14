FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y --no-install-recommends \
    ca-certificates curl unzip \
    php php-cli php-intl php-pgsql php-xml php-curl \
    git fzf vim less 

RUN curl -s https://getcomposer.org/installer -o installer.php && \  
  php installer.php --install-dir=/usr/local/bin --filename=composer

RUN echo "curl.cainfo=/etc/ssl/certs/ca-certificates.crt" >> /etc/php/8.3/cli/php.ini && \
  echo "openssl.cafile=/etc/ssl/certs/ca-certificates.crt" >> /etc/php/8.3/cli/php.ini

WORKDIR /work

ENTRYPOINT ["/usr/local/bin/composer"]