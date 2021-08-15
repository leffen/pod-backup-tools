#!/bin/bash
echo "Backupscript for suitecrm database and files"
echo "Started: $(date)"
echo "--------"
echo "Existing backups:"
ls -aslR /backup
echo "--------"
BACKUPDIR="/backup/$(date +%Y-%m-%d-%N)"
echo "Backup to ${BACKUPDIR}"
mkdir -p ${BACKUPDIR}
/usr/bin/mysqldump -u ${SUITECRM_DATABASE_USER} -p${SUITECRM_DATABASE_PASSWORD} -h ${SUITECRM_DATABASE_HOST} ${SUITECRM_DATABASE_NAME} --single-transaction --quick --lock-tables=false > ${BACKUPDIR}/${SUITECRM_DATABASE_NAME}.sql
cd ${BACKUPDIR}
tar cvfz ${SUITECRM_DATABASE_NAME}.tar.gz ${SUITECRM_DATABASE_NAME}.sql
rm -rf ${SUITECRM_DATABASE_NAME}.sql
echo "--------"
echo Deleting old backups
find /backup -type f -mtime +30 -exec rm {} \;
echo "--------"
echo "Backups after:"
ls -aslR ${BACKUPDIR}
echo "Finished: $(date)"