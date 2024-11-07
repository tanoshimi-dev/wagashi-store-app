FROM php:8.2-fpm

WORKDIR /var/www/html
 
COPY src .

RUN apt-get update
RUN docker-php-ext-install pdo pdo_mysql
COPY --from=composer/composer:2-bin /composer /usr/bin/composer
