#!/bin/sh

# Set ownership of mounted volume
# This helps with permission issues on startup
chown -R www-data:www-data /var/www/html

# Start PHP-FPM in the background
php-fpm &

# Start Nginx in the foreground
nginx -g "daemon off;"