#!/bin/bash

#Ejercicio 2: Automatización del escaneo de puertos

#Objetivo: Automatizar el escaneo de puertos con un script Bash.

#Pasos:

#Crea un script Bash llamado "port_scan.sh".
#Utiliza Nmap en el script para escanear un rango de direcciones IP o un solo host.
#Guarda los resultados del escaneo en un archivo de texto.
#Ejecuta el script y verifica que funcione correctamente.


function escaneoIpRange() {
    local ips="$1"
    local result

    if [ -z "$ips" ]; then
        echo "Debe proporcionar un rango de direcciones IP."
        return 1
    fi

    if [[ ! $ips =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]$ ]]; then
        echo -e "\n${redColour}[!] Error: Dirección IP no válida.${endColour}\n"
        tput cnorm
        exit 1
    fi

    result=$(nmap -sV -p- -T4 "$ips")

    echo "$result" > archive.txt
}

# Llama a la función proporcionando un rango de direcciones IP
escaneoIpRange "192.168.1.1"