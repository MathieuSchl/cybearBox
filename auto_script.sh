#!/bin/bash

# Commandes à exécuter une fois l'adresse IP attribuée

# Récupérer l'adresse IP
#target=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')


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
#if check_interface_ip "eth0"; then
#    echo "Adresse IP trouvée sur eth0 : $target"
#else
    # Si aucune adresse IP sur eth0, vérifie wlan0
#    if check_interface_ip "wlan0"; then
 #       echo "Adresse IP trouvée sur wlan0 : $target"
  #  else
   #     echo "Aucune adresse IP trouvée sur eth0 ou wlan0"
    #    exit 1
   # fi
#fi


output_file="/home/ynta/Desktop/Workdir/Hackathon_result.txt"

# Outils utilisés

                                nslookup $target >> "$output_file"

echo "----------------------------------------------------------------------------------------------------------------------"

                                dig $target >> "$output_file"

echo "----------------------------------------------------------------------------------------------------------------------"


                                dnsrecon -d "$target" >> "$output_file"

echo "----------------------------------------------------------------------------------------------------------------------"

                                lbd $target >> "$output_file"

echo "----------------------------------------------------------------------------------------------------------------------"                           


                                whois $target >> "$output_file"

echo "----------------------------------------------------------------------------------------------------------------------"                           

                                arping -c 5 $target >> "$output_file"

