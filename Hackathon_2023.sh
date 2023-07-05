#!/bin/bash
#Yanis le 04/07/2023
#Projet Master Cyber Sécurité - Hackathon 2023


# Récupérer l'adresse IP
target=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')


# Outils utilisés

				nslookup $target
				
echo "----------------------------------------------------------------------------------------------------------------------"

				dig $target

echo "----------------------------------------------------------------------------------------------------------------------"


				dnsrecon -d "$target"

echo "----------------------------------------------------------------------------------------------------------------------"


				hping3 $target_ip -c $packets_count -p $dest_port


echo "----------------------------------------------------------------------------------------------------------------------"				

				lbd $target

echo "----------------------------------------------------------------------------------------------------------------------"				


				whois $target

				
echo "----------------------------------------------------------------------------------------------------------------------"				

				arping -c 5 $target

echo "----------------------------------------------------------------------------------------------------------------------"				
			

				dnsenum $target
				dnsenum --enum -p 1-65535 $target


echo "----------------------------------------------------------------------------------------------------------------------"				

				
				dnstracer -o -r -v $target
				

echo "----------------------------------------------------------------------------------------------------------------------"				
				netdiscover -i eth0


				echo "1. Enregistrements NS :"
				host -t ns $target

				echo ""

				echo "2. Enregistrements MX :"
				host -t mx $target

				echo ""

				echo "3. Enregistrements A :"
				host -t a $target

				echo ""

				echo "4. Enregistrements AAAA :"
				host -t aaaa $target

				echo ""

				echo "5. Enregistrements CNAME :"
				host -t cname $target

				echo ""

				echo "6. Enregistrements TXT :"
				host -t txt $target

				echo ""

				echo "7. Recherche de sous-domaines :"
				host -l $target

				echo ""
				echo "Le scan est terminé"


echo "----------------------------------------------------------------------------------------------------------------------"				


				enum4linux $target

nmap $target

echo "----------------------------------------------------------------------------------------------------------------------"				
