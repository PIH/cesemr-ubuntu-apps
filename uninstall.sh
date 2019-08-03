#! /bin/bash

for APP_NAME in update_pihemr pihemr_logs restart_pihemr pihemr_export pihemr_restore
do
    sudo rm /etc/puppet/bin/${APP_NAME}.sh
    sudo rm /usr/share/icons/hicolor/scalable/apps/${APP_NAME}.*
    sudo rm /usr/share/applications/${APP_NAME}.desktop
done

sudo rm /etc/cron.daily/simple_backup
