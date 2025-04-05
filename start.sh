#!/bin/bash

# Establecer directorio de trabajo
cd /var/www/html

# Ejecutar scripts de despliegue
echo "Running composer..."
composer install --no-dev

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Running migrations..."
php artisan migrate --force

# Iniciar servidor de Laravel
echo "Starting Laravel server on port ${PORT:-8000}..."
php artisan serve --host=0.0.0.0 --port=${PORT:-8000}