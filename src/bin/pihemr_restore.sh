#!/bin/bash

BACKUP_DIR=/home/doc/openmrs-backup/
DATABASE=openmrs

echo Aquí esta la lista de copias de seguridad del baso de datos de PIH EMR.
echo
ls ${BACKUP_DIR}
echo

function GetFilename {
	echo Entrar el numero del dia para que quieres regresar al backup.
	read DAY
	BACKUP_FILENAME=$(ls ${BACKUP_DIR}/$(date +%Y-)*-${DAY}*)
	if [ "${BACKUP_FILENAME}" = "" ]; then
		echo No hay copia de seguridad para el ${DAY}.
		echo
		GetFilename
	fi
}
function Confirm {
	echo
	echo Quieres usar la copia de seguridad ${BACKUP_FILENAME}? s/n
	read CONFIRM
	if [ "${CONFIRM}" = "s" ]; then
		echo Ok, vamos.
		echo Estoy haciendo una otra copia de seguridad ahora...
		echo
		/etc/puppet/simple-backup.sh
		echo
		echo Ok, ya. Y ahora para cargar este copia de seguridad del \
			${DIA} al base de datos...
		echo 
        TMP_DIR=sql-tmp/
        mkdir -p ${TMP_DIR}
        7za e ${BACKUP_FILENAME} -pBACKUP_PASSWORD -o${TMP_DIR}
		mysql -u openmrs --password='MYSQL_OPENMRS_PASSWORD' -D ${DATABASE} <${TMP_DIR}/backup.sql
        rm -r ${TMP_DIR}
		echo Ya!
	elif [ "${CONFIRM}" = "n" ]; then
		GetFilename
		Confirm
	else
		echo Por favor elegir uno de \'s\' o \'n\'.
		Confirm
	fi
}

GetFilename
Confirm
