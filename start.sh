#!/bin/bash

# Configurar nginx para usar el puerto asignado por Render
if [ -n "$PORT" ]; then
    echo "Configuring nginx for PORT: $PORT"
    sed -i "s/listen 80;/listen $PORT;/" /etc/nginx/sites-available/default
fi

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

echo "Starting PHP-FPM in foreground..."
php-fpm -F