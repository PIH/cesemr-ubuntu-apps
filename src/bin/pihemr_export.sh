#!/bin/sh

echo Creando un archivo del baso de datos de PIH EMR.
echo 
echo Al final, puedes verlo por hacer clic en el icon de cabineta \
	a la izquierda. El archivo se llama \"laguna-emr.sql\"
echo
echo
echo
echo
mysqldump -u openmrs --password='MYSQL_OPENMRS_PASSWORD' openmrs >~/laguna-emr.sql
# ideally filename should be ${HOSTNAME}-$(date +$Y-$M).sql
# but it's resolving to '--.sql' which is not awesome
