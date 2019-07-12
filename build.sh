#!/bin/bash
#
# Creates Debian packages for various PIH EMR utilities.
#

sudo echo  # need root

BUILD_DIR=_build

# Clean out build dir
if [ -d ${BUILD_DIR} ]; then
    rm -rf --preserve-root ${BUILD_DIR}
fi
mkdir -p ${BUILD_DIR}

# Interpolate database password
echo Please enter the password for MySQL user \"openmrs\"
read -s MYSQL_OPENMRS_PASSWORD

# Build the apps
for APP_NAME in update_pihemr pihemr_logs restart_pihemr pihemr_export pihemr_restore simple_backup
do
	VERSION=0.1
	PACKAGE_NAME=${APP_NAME}_${VERSION}-1

	DEB_ROOT=${BUILD_DIR}/${PACKAGE_NAME}


    BIN_SRC=src/bin/${APP_NAME}.sh
    if [ -f "${BIN_SRC}" ]; then
        BIN_DIR=${DEB_ROOT}/etc/puppet/bin
        mkdir -p ${BIN_DIR}
        sed "s/MYSQL_OPENMRS_PASSWORD/${MYSQL_OPENMRS_PASSWORD}/" ${BIN_SRC} \
            > ${BIN_DIR}/${APP_NAME}.sh
        chmod +x ${BIN_DIR}/${APP_NAME}.sh
    fi

    DESKTOP_SRC=src/desktop/${APP_NAME}.desktop
    if [ -f "${DESKTOP_SRC}" ]; then
        DESKTOP_DIR=${DEB_ROOT}/usr/share/applications
        mkdir -p ${DESKTOP_DIR}
        DESKTOP_TARGET=${DESKTOP_DIR}/${APP_NAME}.desktop
        cp ${DESKTOP_SRC} ${DESKTOP_TARGET}
        chmod 644 ${DESKTOP_TARGET}
        sudo chown root:root ${DESKTOP_TARGET}
    fi

    if [ -f src/icon/${APP_NAME}* ]; then
        ICON_DIR=${DEB_ROOT}/usr/share/icons/hicolor/scalable/apps
        mkdir -p ${ICON_DIR}
        cp src/icon/${APP_NAME}* ${ICON_DIR}
    fi

	mkdir -p ${DEB_ROOT}/DEBIAN
	cp -r src/DEBIAN/control.${APP_NAME} ${DEB_ROOT}/DEBIAN/control

	mkdir -p dist/
	dpkg-deb --build ${DEB_ROOT} dist/${APP_NAME}.deb
done
