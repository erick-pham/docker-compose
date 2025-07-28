FROM php:8.2-apache

LABEL maintainer="erick.pham@360f.com" \
      version="1.0" \
      description="Dockerfile for SuiteCRM 8.8.0 with PHP 8.2 and Apache"

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    libldap2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libmariadb-dev \
    libkrb5-dev \
    libc-client2007e-dev && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install \
        imap \
        gd \
        pdo \
        pdo_mysql \
        mbstring \
        xml \
        zip \
        curl \
        intl \
        ldap \
        mysqli \
        soap && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache modules
RUN a2enmod rewrite ssl && \
    a2dissite 000-default.conf

# Set working directory
WORKDIR /var/www/html/

# Copy custom PHP configs and packages
COPY custom_php/ custom_php/
COPY custom_packages/ custom_packages/

# Prepare application directory (volume mount target)
RUN mkdir -p SuiteCRM

# Add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["docker-entrypoint.sh"]