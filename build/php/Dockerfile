FROM php:8.3-apache

# Устанавливаем необходимые расширения PHP
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Устанавливаем зависимости для OpenCart
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip

# Копируем файлы OpenCart в контейнер
COPY ../../app/ /var/www/html/

# Копируем настройки php
COPY ./php.ini ${PHP_INI_DIR}/conf.d/99-php.ini

# Устанавливаем права доступа
RUN chown -R www-data:www-data /var/www/html

# Добавление конфигурации ServerName
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Открываем порт 80
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]