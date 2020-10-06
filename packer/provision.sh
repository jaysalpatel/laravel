
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD . /var/www/html
WORKDIR /var/www/html

RUN mkdir storage/logs
RUN touch storage/logs/laravel.log

RUN composer install
RUN php artisan cache:clear
RUN php artisan view:clear
RUN php artisan route:cache

RUN chmod -R 777 /var/www/html/storage

CMD ["/bin/sh", "-c", "php-fpm -D | tail -f storage/logs/laravel.log"]
