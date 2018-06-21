FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends dialog software-properties-common \
  && apt-get update \
  && apt-get install -y --no-install-recommends software-properties-common \
  && apt-get update

RUN apt-get install -y --no-install-recommends \
    apache2 \
    php7.2 \
    php7.2-mysql \
    mysql-client \
    php7.2-xml \
    php7.2-mbstring \
    php7.2-zip \
    php7.2-intl \
    php7.2-curl \
    curl \
    libapache2-mod-php7.2 \
    composer \
    nano \
    python \
    python3 \
    python-pip \
    python3-distutils \
    zip \
    unzip \
    graphviz \
    fop \
    xsltproc \
    ghostscript \
    git \
    xpdf-utils \
    mscgen \
    pandoc \
    imagemagick \
    php-imagick \
    rsync \
  && apt-get clean \
  && rm -rf /var/lib/apt

COPY init.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/init.sh

RUN rm /var/www/html/index.html

RUN curl -s https://releases.wikimedia.org/mediawiki/1.31/mediawiki-1.31.0.tar.gz | \
    tar xz \
    -C /var/www/html \
    --strip-components=1

RUN chmod 777 -R /var/www/html/images

RUN mkdir /tmp/composer_home

COPY composer.local.json /var/www/html/
COPY Main_page_sampleContent /var/www/html/

RUN COMPOSER_HOME=/tmp/composer_home \
    COMPOSER_ALLOW_SUPERUSER=1 \
    composer update \
    --prefer-dist \
    --no-dev \
    --optimize-autoloader \
    --no-progress \
    -d /var/www/html

RUN COMPOSER_HOME=/tmp/composer_home composer clear-cache 

ADD . /code

WORKDIR /code

CMD ["init.sh"]
