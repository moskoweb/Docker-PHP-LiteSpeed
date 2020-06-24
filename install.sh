#!/bin/bash

if [ -n "$DB_NAME" ]; then
    echo "MySQL | Create database"
    mysql --no-defaults -h $DB_HOST --port $DB_PORT -u $DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
fi

cd /var/www/vhosts/localhost/html

echo "<h1>Hello World!</h1>" >> index.php

chown -R lsadm:lsadm .*

chmod -R g+rw .*

chown -R lsadm:lsadm *

chmod -R g+rw *

echo "PHP | Ini Set Values"
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = $PHP_INI_MAXFILE_SIZE/g" /usr/local/lsws/lsphp74/etc/php/7.4/litespeed/php.ini
sed -i "s/post_max_size = 8M/post_max_size = $PHP_INI_MAXFILE_SIZE/g" /usr/local/lsws/lsphp74/etc/php/7.4/litespeed/php.ini
sed -i "s/max_execution_time = 30/max_execution_time = $PHP_INI_EXECUTION_TIME/g" /usr/local/lsws/lsphp74/etc/php/7.4/litespeed/php.ini
sed -i "s/max_input_time = 60/max_input_time = $PHP_INI_EXECUTION_TIME/g" /usr/local/lsws/lsphp74/etc/php/7.4/litespeed/php.ini
sed -i "s/memory_limit = 128M/memory_limit = $PHP_INI_MEMORY_LIMIT/g" /usr/local/lsws/lsphp74/etc/php/7.4/litespeed/php.ini
sed -i "s/;max_input_vars = 1000/max_input_vars = 3000/g" /usr/local/lsws/lsphp74/etc/php/7.4/litespeed/php.ini

/usr/local/lsws/bin/lswsctrl restart

echo "PHP | Install Completed"
