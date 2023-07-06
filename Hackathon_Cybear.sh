#!/bin/bash
#Yanis le 07/07/2023
#Projet Master Cyber Sécurité - Hackathon 2023


if [[ $EUID -ne 0 ]]; then
  # Relancer le script en tant que superutilisateur (root) ou avec sudo
  sudo bash "$0"
  exit
fi


ip_eth0=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(.\d+){3}')
ip_wlan0=$(ip addr show wlan0 | grep -oP '(?<=inet\s)\d+(.\d+){3}')


fonction_eth0() {
echo "============================================"
echo "---------------- whois ---------------------"
echo "============================================" 

 whois $ip_eth0



  echo "==========================================="
  echo "---------------- host ---------------------"
  echo "==========================================="
  echo "Recherche DNS :"
  echo "==========================================="

  echo "1. Enregistrements NS :"
  host -t ns $ip_eth0

  echo "2. Enregistrements MX :"
  host -t mx $ip_eth0

  echo "3. Enregistrements A :"
  host -t a $ip_eth0

  echo "4. Enregistrements AAAA :"
  host -t aaaa $ip_eth0

  echo "5. Enregistrements CNAME :"
  host -t cname $ip_eth0

  echo "6. Enregistrements TXT :"
  host -t txt $ip_eth0

  echo "7. Recherche de sous-domaines :"
  host -l $ip_eth0



  echo "============================================"
  echo "----------------- nmap ---------------------"
  echo "============================================" 

  echo "1. Scan de port rapide :"
  nmap -oX - -F -T4 $ip_eth0 >> fichier_ethernet.xml

  echo "2. Scan de ports complet :"
  nmap -oX - -p- -T4 $ip_eth0 >> fichier_ethernet.xml

  echo "3. Scan de vulnérabilités :"
  nmap -oX - -sV -T4 --script vuln  $ip_eth0 >> fichier_ethernet.xml

  echo "4. Scan de sécurité :"
  nmap -oX - -sS -sV -sC -O -T4 $ip_eth0 >> fichier_ethernet.xml

  echo "5. Simple traceroute  :"
  nmap -oX - -sn --traceroute $ip_eth0 >> fichier_ethernet.xml

  sleep 10

  ./Hackathon_Cybear.sh > Hackathon_Cybear_resultats.txt
}



fonction_wlan0() {
  echo"============================================="
  echo "---------------- WHOIS ---------------------"
  echo"=============================================" 

 whois $ip_wlan0



  echo "==========================================="
  echo "---------------- host ---------------------"
  echo "==========================================="
  echo "Recherche DNS :"
  echo "==========================================="

  echo "1. Enregistrements NS :"
  host -t ns $ip_wlan0

  echo "2. Enregistrements MX :"
  host -t mx $ip_wlan0

  echo "3. Enregistrements A :"
  host -t a $ip_wlan0

  echo "4. Enregistrements AAAA :"
  host -t aaaa $ip_wlan0

  echo "5. Enregistrements CNAME :"
  host -t cname $ip_wlan0

  echo "6. Enregistrements TXT :"
  host -t txt $ip_wlan0

  echo "7. Recherche de sous-domaines :"
  host -l $ip_wlan0


  echo "============================================"
  echo "----------------- nmap ---------------------"
  echo "============================================" 

  echo "1. Scan de port rapide :"
  nmap -F -T4 $ip_wlan0 -oX - fichier_wifi.xml

  echo "2. Scan de ports complet :"
  nmap -p- -T4 $ip_wlan0 -oX - fichier_wifi.xml

  echo "3. Scan de vulnérabilités :"
  nmap -sV -T4 --script vuln  $ip_wlan0 -oX - fichier_wifi.xml
 
  echo "4. Scan de sécurité :"
  nmap -sS -sV -sC -O -T4 $ip_wlan0 -oX - fichier_wifi.xml
 
  echo "5. Simple traceroute  :"
  nmap -sn --traceroute $ip_wlan0 -oX - fichier_wifi.xml

  sleep 10

  ./Hackathon_Cybear.sh > Hackathon_Cybear_resultats.txt
}



main() {

  ethernet_interface="eth0"
  wifi_interface="wlan0"

  # Vérification des connexions Ethernet et Wi-Fi
  if ifconfig "$ethernet_interface" >/dev/null 2>&1 && iwconfig "$wifi_interface" >/dev/null 2>&1; then
      echo "Les deux connexions Ethernet (RJ45) et Wi-Fi sont détectées."
      fonction_eth0
      fonction_wlan0
  elif ifconfig "$ethernet_interface" >/dev/null 2>&1; then
      echo "Connexion Ethernet (RJ45) détectée."
      fonction_eth0
  elif iwconfig "$wifi_interface" >/dev/null 2>&1; then
      echo "Connexion Wi-Fi détectée."
      fonction_wlan0
  else
      echo "Pas de connexion Ethernet (RJ45), ni de connexion Wi-Fi."
  fi

}
main

exit
