FROM composer:7.3 as composer
ENV APP_NAME=socialmedia
ENV APP_ENV=dev
ENV APP_URL=http://localhost:8000
ENV RUN_USER daemon
ENV RUN_GROUP daemon
ENV INSTALL_DIR /opt/navi
ENV DB_HOST 127.0.0.1
ENV DB_PORT 3306
ENV DB_DATABASE freecodegram
ENV DB_USERNAME user1
ENV DB_PASSWORD password
ENV LOGIN_COPTCHA true 
ENV PATH=./vendor/bin:/composer/vendor/bin:/root/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV COMPOSER_ALLOW_SUPERUSER=1
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

RUN php -v && \
    git --version && \
    composer --version


WORKDIR ${INSTALL_DIR}
CMD ["/entrypoint.sh", "serve"]
ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR /app
COPY . /app
RUN composer install 

RUN npm run dev
RUN php artisan serve
EXPOSE 8000
CMD ["php", "artisan", "serve"]