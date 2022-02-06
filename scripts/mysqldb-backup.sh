#!/bin/bash
echo "Backupscript for suitecrm database and files"
echo "Started: $(date)"
echo "--------"
echo "Existing backups:"
ls -aslR /wp-backup
echo "--------"
BACKUPDIR="/wp-backup/$(date +%Y-%m-%d-%N)"
echo "Backup to ${BACKUPDIR}"
mkdir -p ${BACKUPDIR}
/usr/bin/mysqldump -u ${DATABASE_USER} -p${DATABASE_PASSWORD} -h ${DATABASE_HOST} ${DATABASE_NAME} --single-transaction --quick --lock-tables=false > ${BACKUPDIR}/${DATABASE_NAME}.sql
cd ${BACKUPDIR}
tar cvfz ${DATABASE_NAME}.tar.gz ${DATABASE_NAME}.sql
rm -rf ${DATABASE_NAME}.sql
echo "--------"
echo Deleting old backups
find /backup -type f -mtime +30 -exec rm {} \;
echo "--------"
echo "Backups after:"
ls -aslR ${BACKUPDIR}
echo "Finished: $(date)"