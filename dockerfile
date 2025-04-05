FROM php:8.2-cli

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip

# Limpiar cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar extensiones PHP
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Obtener Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar directorio de trabajo
WORKDIR /var/www/html

# Copiar código del proyecto
COPY . .

# Configurar permisos
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Usar nuestro script personalizado
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exponer el puerto que Render asignará
EXPOSE 8000

CMD ["/start.sh"]