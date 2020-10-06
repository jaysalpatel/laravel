FROM composer:7.2 as composer

##setting environment variables
ENV RUN_USER daemon
ENV RUN_GROUP daemon
ENV DB_HOST 127.0.0.1
ENV DB_PORT 3306
ENV DB_DATABASE laravel-database
ENV DB_USERNAME admin
ENV DB_PASSWORD password
ENV LOGIN_COPTCHA true 
ENV PATH=./vendor/bin:/composer/vendor/bin:/root/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV COMPOSER_ALLOW_SUPERUSER=1
EXPOSE 8000

WORKDIR /src
COPY ./laravel-project /src
ENV COMPOSER_ALLOW_SUPERUSER 1
#RUN echo "{\"github-oauth\": {\"github.com\": \"$TOKEN\"}}" > /tmp/auth.json
RUN composer install --no-interaction --no-dev --prefer-dist


### compile js & css assets
FROM node:14.13.0 as node
WORKDIR /node
COPY --from=composer /src /node
RUN npm i && \
		npm run production
RUN rm -rf /node/node_modules


## build app container
FROM alpine:3.12
WORKDIR /app
COPY ./terraform /app 
COPY --from=node /node /app

# set requirement privileges
RUN chown -R 9000:9000 storage && \
	chown -R 9000:9000 bootstrap/cache && \
	chmod -R ug+rwx    bootstrap/cache && \
	chgrp -R 9000      bootstrap/cache && \
	chmod +x artisan && \
	chmod +x /provision.sh

# create init script
RUN echo '#!/bin/sh'                   > /init.sh && \
	echo 'echo "app init started!"'   >> /init.sh && \
	echo 'cp -rp /app/*    /src'      >> /init.sh && \
	echo 'cp -rp /* /cfg'   	  >> /init.sh && \
	echo 'echo "app init completed!"' >> /init.sh && \
	chmod +x /init.sh

CMD [ "sh", "-c", "/init.sh" ]