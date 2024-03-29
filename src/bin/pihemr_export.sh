#!/bin/bash

set -eEo pipefail  # same as: `set -o errexit -o errtrace -o pipefail`
trap catch_error ERR 

RED="\e[01;31m"

function catch_error {
    echo
    echo -e ${RED}===ERROR===_
    echo
    echo Encontró un error grave! Por favor empuje el botón Impr Pant y enviar el imagen al administrador del EMR.
    echo
    read -p "Después que imprimes la pantalla, empuje enter para continuar."
    exit 1
}

echo Creando un archivo del baso de datos de PIH EMR.
echo 
echo Al final, puedes verlo por hacer clic en el icon de cabineta \
	a la izquierda. El archivo se llama \"pihemr-archivo.sql.7z\"
echo
echo
echo
SQL_NAME=pihemr-archivo.sql
mysqldump -u openmrs --password='MYSQL_OPENMRS_PASSWORD' --opt --flush-logs --single-transaction openmrs | 7za a -pBACKUP_PASSWORD -si${SQL_NAME} -t7z ~/${SQL_NAME}.7z -mx9 2>&1
# ideally filename should be ${HOSTNAME}-$(date +$Y-$M).sql.7z
# but it's resolving to '--.sql.7z' which is not awesome
