# Pull base image.
FROM ubuntu:14.04

# Install Nginx.
RUN \
  apt-get update && \
  apt-get install -y supervisor software-properties-common && \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx php5-fpm php5-mysql && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ncgi.fix_pathinfo=0" >> /etc/php5/fpm/php.ini && \
  chown -R www-data:www-data /var/lib/nginx && \
  rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["/usr/bin/supervisord"]

# Expose ports.
EXPOSE 80
EXPOSE 443
