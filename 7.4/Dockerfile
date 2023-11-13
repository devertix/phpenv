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
    php7.4-cli \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-soap \
    php7.4-curl \
    php7.4-gd \
    php7.4-bz2 \
    php7.4-zip \
    php7.4-mysql \
    php7.4-fpm \
    php7.4-sqlite3 \
    php7.4-bcmath \
    php7.4-intl \
    php7.4-xdebug \
    php7.4-redis \
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
    echo "include=/dev/shm/fpm-user.conf" >> /etc/php/7.4/fpm/pool.d/www.conf && \
    echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 80

WORKDIR /project

ENV HOME=/tmp

CMD ["/usr/bin/supervisord"]
