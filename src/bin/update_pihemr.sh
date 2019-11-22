#!/bin/bash

set -eE  # same as: `set -o errexit -o errtrace`
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

cd /etc/puppet

echo Actualizando los apps de PIH EMR...
echo
echo

function update_apps {
    sudo ./build.sh
    sudo ./install.sh
}

if [ ! -d "/etc/puppet/cesemr-ubuntu-apps" ]; then
    sudo git clone https://github.com/PIH/cesemr-ubuntu-apps.git
    cd cesemr-ubuntu-apps/
    update_apps
else
    cd cesemr-ubuntu-apps/
    sudo git remote update

    LOCAL=$(git rev-parse master)
    REMOTE=$(git rev-parse origin/master)

    if [ $LOCAL = $REMOTE ]; then
        echo "PIH EMR Apps actualizado"
    else 
        sudo git reset --hard origin/master
        update_apps
    fi
fi

cd /etc/puppet/
echo
echo Los PIH EMR apps son actualizados.
echo ----------------------------------
echo
echo Ahora vamos a actualizar el EMR.
echo 
echo Empuje \"Enter\" despues del texto abajo.
echo
echo

sudo git remote update
sudo git reset --hard origin/master
sudo ./install.sh

