#!/bin/bash
echo "Backupscript for bitnami wordpress content files"
echo "Started: $(date)"
echo "--------"
echo "Existing backups:"

export BACKUP_ROOT_DIR=${HOME}/wp-backup

ls -aslR ${BACKUP_ROOT_DIR}
echo "--------"
BACKUPDIR="${HOME}/wp-content-backup/$(date +%Y%m%d-%H%M)"
echo "Backup to ${BACKUPDIR}"
mkdir -p ${BACKUPDIR}
cd ${BACKUPDIR}
tar cvfz ${DATABASE_NAME}.tar.gz ${WORDPRESS_CONTENT_DIR}
echo "--------"
echo Deleting old backups
find ${BACKUP_ROOT_DIR} -type f -mtime +30 -exec rm {} \;
echo "--------"
echo "Backups after:"
ls -aslR ${BACKUP_ROOT_DIR}
echo "Finished: $(date)"