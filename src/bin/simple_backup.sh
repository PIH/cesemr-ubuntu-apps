#!/bin/sh

_USER=doc  # to avoid clobbering $USER
BACKUP_DIR=/home/${_USER}/openmrs-backup/

mkdir -p ${BACKUP_DIR}
chown ${_USER}:${_USER} ${BACKUP_DIR}

FILENAME=$(date -Iminutes)

mysqldump -u openmrs --password='MYSQL_OPENMRS_PASSWORD' openmrs > ${BACKUP_DIR}/${FILENAME}

# clear old
rm ${BACKUP_DIR}/$(date --date='last month' +%Y-%M)*
