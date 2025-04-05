#!/bin/bash

# Ejecutar scripts de despliegue
echo "Running composer..."
composer install --no-dev --working-dir=/var/www/html

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Running migrations..."
php artisan migrate --force

# Iniciar nginx y php-fpm
echo "Starting nginx..."
service nginx start

echo "Starting PHP-FPM..."
php-fpm