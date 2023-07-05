#!/bin/bash

# Affiche un message lorsque l'adresse IP est attribuée
echo "L'adresse IP a été attribuée. Mon script s'exécute maintenant."

# Commandes à exécuter une fois l'adresse IP attribuée
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

