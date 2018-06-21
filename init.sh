#!/bin/bash
file_deployed="/var/www/html/.deployed"

DB_HOST=mysql
DB_PASSWORD=mysecretpassword

while ! mysqladmin ping -h"$DB_HOST" -p"$DB_PASSWORD" --silent; do
    sleep 1
done

if [ ! -f "$file_deployed" ]
then
    php /var/www/html/maintenance/install.php \
        Wiki_Name \
        admin \
        --pass admin123 \
        --dbtype mysql \
        --dbserver "$DB_HOST" \
        --dbname wiki_database \
        --dbuser root \
        --dbpass "$DB_PASSWORD" \
        --wiki wiki \
        --dbschema mediawiki \
        --scriptpath ""

    php /var/www/html/maintenance/edit.php -s "Add this page" -m Main_Page < /var/www/html/Main_page_sampleContent
    
    cat <<EOT >> /var/www/html/LocalSettings.php
#Include the docbookexport plugin
wfLoadExtension( 'DocBookExport' );
EOT

    touch $file_deployed
fi
apachectl -DFOREGROUND