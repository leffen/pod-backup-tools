#!/bin/bash

# Restore of mysql data into database
echo "Restorescript for mysql database "
echo "Started: $(date)"
echo "--------"

export BACKUP_ROOT_DIR=${HOME}/wp-backup

ls -aslR ${BACKUP_ROOT_DIR}
echo "--------"

BACKUPDIR="${HOME}/wp-backup/${RESTORE_DATE}"

echo "Restore from ${BACKUPDIR}"

cd ${BACKUPDIR}

tar xvfz ${DATABASE_NAME}.tar.gz

mysql -u ${DATABASE_USER} -p${DATABASE_PASSWORD} ${DATABASE_NAME} <  ${BACKUPDIR}/${DATABASE_NAME}.sql

#/usr/bin/mysqldump -u ${DATABASE_USER} -p${DATABASE_PASSWORD} -h ${DATABASE_HOST} ${DATABASE_NAME} --single-transaction --quick --lock-tables=false > ${BACKUPDIR}/${DATABASE_NAME}.sql

echo "Finished: $(date)"