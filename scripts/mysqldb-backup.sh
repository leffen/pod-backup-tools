#!/bin/bash
echo "Backupscript for suitecrm database and files"
echo "Started: $(date)"
echo "--------"
echo "Existing backups:"

export BACKUP_ROOT_DIR=${HOME}/wp-backup

ls -aslR ${BACKUP_ROOT_DIR}
echo "--------"
BACKUPDIR="${HOME}/wp-backup/$(date +%Y%m%d-%H%M)"
echo "Backup to ${BACKUPDIR}"
mkdir -p ${BACKUPDIR}
/usr/bin/mysqldump -u ${DATABASE_USER} -p${DATABASE_PASSWORD} -h ${DATABASE_HOST} ${DATABASE_NAME} --single-transaction --quick --lock-tables=false > ${BACKUPDIR}/${DATABASE_NAME}.sql
cd ${BACKUPDIR}
tar cvfz ${DATABASE_NAME}.tar.gz ${DATABASE_NAME}.sql
rm -rf ${DATABASE_NAME}.sql
echo "--------"
echo Deleting old backups
find ${BACKUP_ROOT_DIR} -type f -mtime +30 -exec rm {} \;
echo "--------"
echo "Backups after:"
ls -aslR ${BACKUP_ROOT_DIR}
echo "Finished: $(date)"