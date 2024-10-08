FROM php:8.1-fpm-alpine

WORKDIR /var/www/html
 
COPY src .
 
RUN docker-php-ext-install pdo pdo_mysql
COPY --from=composer/composer:2-bin /composer /usr/bin/composer
