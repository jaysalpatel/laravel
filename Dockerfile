FROM php7:laravel
ENV RUN_USER daemon
ENV RUN_GROUP daemon
ENV INSTALL_DIR /opt/navi
ENV DB_HOST 127.0.0.1
ENV DB_PORT 3306
ENV DB_DATABASE homestead
ENV DB_USERNAME homestead
ENV DB_PASSWORD secret
ENV LOGIN_COPTCHA true 

EXPOSE 8000
COPY entrypoint.sh /entrypoint.sh

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    lsb-release \
    ca-certificates \
    curl \
    git \
    zip \
    unzip \
    sudo

ADD https://packages.sury.org/php/apt.gpg /etc/apt/trusted.gpg.d/php.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN chmod 664 /etc/apt/trusted.gpg.d/php.gpg

RUN apt-get update && \
    apt-get install -y \
    php7.4-bcmath \
    php7.4-fpm \
    php7.4-cli \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    php7.4-curl \
    php7.4-intl \
    php7.4-gd \
    php7.4-sqlite3 \
    php7.4-mysql \
    php7.4-pgsql 

RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# Install Laravel Envoy
RUN composer global require "laravel/envoy=~1.0"

RUN php -v && \
    git --version && \
    composer --version

## Change Apache root directory
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


WORKDIR ${INSTALL_DIR}
CMD ["/entrypoint.sh", "serve"]
ENTRYPOINT ["/sbin/tini", "--"]

FROM composer:1.6.5 as build
WORKDIR /app
COPY . /app
RUN composer install 

RUN npm run dev
RUN php artisan serve