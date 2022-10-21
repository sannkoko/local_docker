FROM php:7.4-fpm-alpine

RUN apk add --update \
		$PHPIZE_DEPS \
		freetype-dev \
		git \
		libjpeg-turbo-dev \
		libpng-dev \
		libxml2-dev \
		libzip-dev \
		openssh-client \
		openssl \
		imagemagick-libs \
		imagemagick-dev \
		zip \
		sqlite \
	&& docker-php-ext-install pdo pdo_mysql \
	&& docker-php-ext-configure gd --with-jpeg --with-freetype \
	&& docker-php-ext-install gd \
	&& docker-php-ext-install zip

RUN printf "\n" | pecl install \
		imagick && \
		docker-php-ext-enable --ini-name 20-imagick.ini imagick

RUN printf "\n" | pecl install \
		pcov && \
		docker-php-ext-enable pcov


RUN mkdir -p /var/www/html

RUN apk --no-cache add shadow && usermod -u 1000 www-data
