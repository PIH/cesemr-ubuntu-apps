#! /bin/bash

for APP_NAME in update_pihemr pihemr_logs restart_pihemr pihemr_export pihemr_restore simple_backup
do
    sudo rm /etc/puppet/bin/${APP_NAME}.sh
    sudo rm /usr/share/icons/hicolor/scalable/apps/${APP_NAME}.*
    sudo rm /usr/share/applications/${APP_NAME}.desktop
done
