#!/bin/bash

# Install debian packages
for APP_NAME in update_pihemr pihemr_logs restart_pihemr pihemr_export pihemr_restore simple_backup restart_network reset_pihemr_configuration
do
    sudo dpkg -i dist/${APP_NAME}.deb
done

BACKUP_BIN_TARGET=/etc/cron.daily/simple_backup
sudo cp _build/simple_backup ${BACKUP_BIN_TARGET}
sudo chmod 755 ${BACKUP_BIN_TARGET}
sudo chown root:root ${BACKUP_BIN_TARGET}
