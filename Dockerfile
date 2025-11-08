FROM php:7.4-fpm

RUN apt-get update && apt-get install -y nginx

COPY . /var/www/html/

COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod -R 755 /var/www/html

EXPOSE 80

CMD service php7.4-fpm start && nginx -g 'daemon off;'