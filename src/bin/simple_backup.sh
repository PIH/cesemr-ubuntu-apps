#!/bin/sh

_USER=doc  # to avoid clobbering $USER
BACKUP_DIR=/home/${_USER}/openmrs-backup/

mkdir -p ${BACKUP_DIR}
chown ${_USER}:${_USER} ${BACKUP_DIR}

FILENAME=$(date -Iminutes)

mysqldump -u openmrs --password='MYSQL_OPENMRS_PASSWORD' --opt --flush-logs --single-transaction openmrs 2>/dev/null | 7za a -pBACKUP_PASSWORD -sibackup.sql -t7z ${BACKUP_DIR}/${FILENAME} -mx9 2>&1 >/dev/null

# clear old
find ${BACKUP_DIR} -mtime +15 -exec rm {} \;

