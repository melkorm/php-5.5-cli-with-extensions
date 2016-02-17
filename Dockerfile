FROM php:5.5

MAINTAINER Bartosz Grzybowski <melkorm@gmail.com>

RUN apt-get update \
    && apt-get -y install git --no-install-recommends  \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
        libxml2-dev \
        libicu-dev \
        php5-imap \
        libssh2-php \
        php5-pecl-http \
        libmagickwand-dev \
        openssl \
        libc-client-dev \
        libkrb5-dev \
        libssh2-1-dev \
        libssh2-php \
        ssh \
    && pecl install imagick xdebug memcache \
    && docker-php-ext-enable imagick memcache xdebug \
    && docker-php-ext-install -j$(nproc) iconv mcrypt zip intl xmlrpc bcmath soap mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install imap \
    && rm -r /var/lib/apt/lists/* \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && service ssh start

CMD ["php", "-a"]
