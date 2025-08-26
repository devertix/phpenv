FROM ubuntu:24.04
LABEL maintainer="Norbert Mozsar <norbert.mozsar@devertix.com>"

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
    php8.1-cli \
    php8.1-mbstring \
    php8.1-xml \
    php8.1-soap \
    php8.1-curl \
    php8.1-gd \
    php8.1-bz2 \
    php8.1-zip \
    php8.1-mysql \
    php8.1-fpm \
    php8.1-sqlite3 \
    php8.1-bcmath \
    php8.1-intl \
    php8.1-xdebug \
    php8.1-redis \
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
    echo "include=/dev/shm/fpm-user.conf" >> /etc/php/8.1/fpm/pool.d/www.conf && \
    echo "clear_env = no" >> /etc/php/8.1/fpm/pool.d/www.conf

EXPOSE 80

WORKDIR /project

ENV HOME=/tmp

CMD ["/usr/bin/supervisord"]
