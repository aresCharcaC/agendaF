#!/bin/bash

# Establecer directorio de trabajo
cd /var/www/html

# Mostrar variables de entorno (sin valores sensibles)
echo "Checking environment..."
echo "APP_ENV: $APP_ENV"
echo "APP_DEBUG: $APP_DEBUG"
echo "DB_CONNECTION type: $DB_CONNECTION"
echo "Database connection check..."

# Ejecutar scripts de despliegue
echo "Running composer..."
composer install --no-dev

echo "Clearing configuration cache..."
php artisan config:clear

echo "Checking database connection..."
php artisan db:monitor

echo "Running migrations..."
php artisan migrate --force

# Iniciar servidor de Laravel con más información
echo "Starting Laravel server on port ${PORT:-8000}..."
php artisan serve --host=0.0.0.0 --port=${PORT:-8000} --verbose