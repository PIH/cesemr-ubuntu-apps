#!/bin/bash

# Install debian packages
for APP_NAME in update_pihemr pihemr_logs restart_pihemr pihemr_export pihemr_restore simple_backup
do
    sudo dpkg -i dist/${APP_NAME}.deb
done
