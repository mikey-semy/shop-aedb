FROM php:7.4-apache

# Устанавливаем необходимые расширения PHP и зависимости
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli pdo pdo_mysql gd zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Копируем файлы OpenCart в контейнер
COPY ./app/ /var/www/html/

# Копируем настройки php
COPY ./build/php/php.ini ${PHP_INI_DIR}/conf.d/99-php.ini

# Устанавливаем права доступа
RUN chown -R www-data:www-data /var/www/html

# Добавление конфигурации ServerName
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Монтируем конфиги
VOLUME /var/www/html/config.php
VOLUME /var/www/html/admin/config.php

# Удаляем папку install после первого запуска
RUN if [ -d /var/www/html/install ]; then rm -rf /var/www/html/install; fi

# Открываем порт 80
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]