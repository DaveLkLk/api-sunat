# usar imagen php con apache
FROM php:7.3-apache

# Instala las extensiones necesarias para SOAP, XML y GD
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libpng-dev \
    && docker-php-ext-install soap dom xml mbstring gd

# Opcional: instala cURL si consumes SOAP con HTTP
RUN apt-get install -y libcurl4-openssl-dev \
    && docker-php-ext-install curl

# Copia los archivos de la API al contenedor
COPY . /var/www/html/

# Da permisos adecuados
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expone el puerto 80
EXPOSE 80

# Ejecuta Apache
CMD ["apache2-foreground"]