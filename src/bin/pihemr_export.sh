#!/bin/sh

echo Creando un archivo del baso de datos de PIH EMR.
echo 
echo Al final, puedes verlo por hacer clic en el icon de cabineta \
	a la izquierda. El archivo se llama \"pihemr-archivo.sql.7z\"
echo
echo
echo
SQL_NAME=pihemr-archivo.sql
mysqldump -u openmrs --password='MYSQL_OPENMRS_PASSWORD' --opt --flush-logs --single-transaction openmrs 2>/dev/null | 7za a -pBACKUP_PASSWORD -si${SQL_NAME} -t7z ~/${SQL_NAME}.7z -mx9 2>&1 >/dev/null
# ideally filename should be ${HOSTNAME}-$(date +$Y-$M).sql.7z
# but it's resolving to '--.sql.7z' which is not awesome
