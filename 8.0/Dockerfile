FROM ubuntu:20.04
MAINTAINER Norbert Mozsar <norbert.mozsar@devertix.com>

# apache
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    supervisor \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# php
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    unzip \
    curl \
    apache2 \
    locales \
    php8.0-cli \
    php8.0-mbstring \
    php8.0-xml \
    php8.0-soap \
    php8.0-curl \
    php8.0-gd \
    php8.0-bz2 \
    php8.0-zip \
    php8.0-mysql \
    php8.0-fpm \
    php8.0-sqlite3 \
    php8.0-bcmath \
    php8.0-intl \
    php8.0-xdebug \
    php8.0-redis \
    mysql-client \
    imagemagick \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen hu_HU.UTF-8 && \
    update-locale

RUN a2enmod rewrite && \
    a2enmod actions && \
    a2enmod headers && \
    a2enmod proxy_fcgi && \
    a2enmod proxy_http && \
    a2disconf other-vhosts-access-log

RUN mkdir /project && \
    phpdismod opcache && \
    curl -o /usr/local/bin/composer https://getcomposer.org/composer.phar && \
    chmod +x /usr/local/bin/composer

COPY files/ /

RUN chmod +x /start.sh && \
    mkdir -p /run/php && \
    chmod 777 /run/php && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    echo "include=/dev/shm/fpm-user.conf" >> /etc/php/8.0/fpm/pool.d/www.conf && \
    echo "clear_env = no" >> /etc/php/8.0/fpm/pool.d/www.conf

EXPOSE 80

WORKDIR /project

ENV HOME=/tmp

CMD ["/usr/bin/supervisord"]
