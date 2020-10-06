
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
apt-get update && \
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
cd /var/www/html

mkdir storage/logs
touch storage/logs/laravel.log

RUN composer install
php artisan cache:clear
php artisan view:clear
php artisan route:cache

chmod -R 777 /var/www/html/storage


