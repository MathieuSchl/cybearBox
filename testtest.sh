#!/bin/bash

# Fonction pour vérifier si une adresse IP est attribuée à une interface
check_interface_ip() {
    local interface="$1"
    local ip=$(ip -4 addr show "$interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    
    if [[ -n "$ip" ]]; then
        target="$ip"
        return 0
    else
        return 1
    fi
}

# Vérifie d'abord si une adresse IP est attribuée à eth0
if check_interface_ip "eth0"; then
    echo "Adresse IP trouvée sur eth0 : $target"
else
    # Si aucune adresse IP sur eth0, vérifie wlan0
    if check_interface_ip "wlan0"; then
        echo "Adresse IP trouvée sur wlan0 : $target"
    else
        echo "Aucune adresse IP trouvée sur eth0 ou wlan0"
        exit 1
    fi
fi
