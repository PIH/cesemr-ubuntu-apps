#!/bin/bash

mysql -u openmrs --password='MYSQL_OPENMRS_PASSWORD' -e \
  "update global_property set property_value='true' where property like '%started%';" \
  openmrs

sudo rm -r ~tomcat7/.OpenMRS/configuration_checksums
sudo service tomcat7 restart
