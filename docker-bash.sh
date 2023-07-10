#!/bin/bash

#
# Simple menu to start bash on one of your running Docker containers
#
# Requires the "dialog" package:
#
# brew install dialog
# apt install dialog
# ... or however you get packages on your system!
#
# I run this from an alias: alias db="bash ~/somewhere/docker-bash/docker-bash.sh"
#


CONTAINERS=($(docker ps --format '{{ .Names }}'))

MENU_OPTIONS=""

for i in ${!CONTAINERS[@]}; do
    MENU_OPTIONS="${MENU_OPTIONS} $i ${CONTAINERS[$i]}"
done
d

CHOICE=$(dialog --menu "Select container:" 10 30 5 \
    ${MENU_OPTIONS} \
2>&1 >/dev/tty)

BUTTON=$?
if [ $BUTTON -eq "0" ];
then
    echo -e "\n\nStarting bash on ${CONTAINERS[$CHOICE]}...\n"
    docker exec -it ${CONTAINERS[$CHOICE]} bash
fi
