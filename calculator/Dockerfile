FROM ubuntu:latest

RUN apt-get -y update --fix-missing && apt-get upgrade -y && apt-get -y install apache2

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

RUN apt-get -y update --fix-missing && apt-get -y install software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get clean \
    && apt-get -y update \
    && apt-get -y install php7.2-dev

# Install important libraries
RUN apt-get -y install --fix-missing apt-utils nano wget build-essential \
    git libcurl4-openssl-dev zip \
    libmcrypt-dev libsqlite3-dev libsqlite3-0 mysql-client zlib1g-dev \
    libicu-dev libfreetype6-dev libjpeg62-dev libpng-dev php-pear

RUN apt-get -y install libapache2-mod-php7.2 \
	php7.2-cli php7.2-xml php7.2-mbstring \
    php7.2-zip php7.2-mysql php7.2-gd php7.2-imagick \
    php7.2-recode php7.2-tidy php7.2-xmlrpc curl php7.2-curl php7.2-gmp

RUN apt-get -y install php-common php-mbstring php-xml php-zip

#RUN apt-get -y  install php7.1-curl \
#    && apt-get install php7.1-gmp 

RUN phpenmod mcrypt && phpenmod mbstring

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN apt-get -y install php-pear

RUN ln -f -s .env .env

RUN a2enmod headers && a2enmod rewrite

COPY . .

RUN composer install

#RUN apt-get -y update && apt-get -y install -f

#RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

#RUN apt-get -y install nodejs

#RUN npm install

RUN service apache2 restart

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html

EXPOSE 80

RUN chmod -R 775 .

RUN chown -R www-data:www-data .

CMD php artisan migrate

CMD php artisan storage:link

#RUN chown -R www-data /var/www/html

#RUN chown -R www-data:www-data /var/www/html/storage

#RUN npm run

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]

