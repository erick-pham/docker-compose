# FROM httpd:latest
# FROM php:7.4-apache
FROM ubuntu:18.04
WORKDIR /var/www/html
# RUN mkdir suitecrm
# COPY ./SuiteCRM-7.11.18/* ./suitecrm/
COPY ./SuiteCRM-7.11.18/ /var/www/html/suitecrm/
COPY index.html /var/www/html
COPY info.php /var/www/html

RUN chown -R www-data:www-data .
RUN chmod -R 755 .
RUN chmod -R 775 suitecrm/cache suitecrm/custom suitecrm/modules suitecrm/themes suitecrm/data suitecrm/upload

# RUN apt-get update
# RUN apt-get install software-properties-common -y
# RUN apt-add-repository ppa:ondrej/php
# RUN apt-get install wget -y
# RUN apt install mysql-server -y
# RUN apt-get install php php-json php-xml php-mbstring php-imap libapache2-mod-php php-mysql -y
# RUN a2enmod wsgi

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-add-repository ppa:ondrej/php

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq -y install curl
RUN apt-get -y install apache2
RUN apt-get -y install php7.4
RUN apt-get -y install libapache2-mod-php7.4
RUN apt-get -y install php7.4-mysql
RUN apt-get -y install php7.4-gd
RUN apt-get -y install php-pear
RUN apt-get -y install php7.4-curl
RUN apt-get -y install php7.4-mbstrin
RUN apt-get -y install php-imagick
RUN apt-get -y install curl
# RUN apt-get -y install lynx-cur
RUN apt-get -y install php7.4-zip
RUN apt-get -y install php7.4-xml
RUN apt-get -y install php7.4-imap

# COPY 000-default.conf /etc/apache2/sites-available
COPY suitecrm.com.vn.conf /etc/apache2/sites-enabled
COPY suitecrm.com.vn.conf /etc/apache2/sites-available
COPY httpd.conf /etc/apache2

COPY dir.conf /etc/apache2/mods-enabled
COPY php.ini /etc/php/7.4/apache2
# COPY config.php /var/www/html/suitecrm
# RUN a2ensite /usr/local/apache2/sites-available/suitecrm.com.vn.conf
# RUN chmod 775 config_override.php 2>/dev/null
RUN a2enmod rewrite

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
EXPOSE 80

# CMD [ "php", "./entryPoint.php" ]