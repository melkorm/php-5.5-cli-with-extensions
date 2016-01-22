FROM php:5.5

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
        php5-imagick \
    && pecl install memcache \
    && docker-php-ext-install -j$(nproc) iconv mcrypt zip intl xmlrpc bcmath soap mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable ssh2 \
    && docker-php-ext-enable imap \
    && docker-php-ext-enable http \
    && docker-php-ext-enable memcache \
    && docker-php-ext-enable imagic \
    && rm -r /var/lib/apt/lists/*
    
    
CMD ["php", "-a"]
