FROM php:7.4-cli

# install os packages
RUN apt-get update && apt-get install -y \
        curl \
        libzip-dev \
        zip

# install composer
ENV COMPOSER_MEMORY_LIMIT=4.0G
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN mkdir /.composer
VOLUME /.composer

# php
RUN docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) sockets

RUN rm -rf /var/lib/apt/lists/*
