FROM drupal

RUN apt-get update \
    && apt-get install -y \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /var/www/html/

EXPOSE 80
