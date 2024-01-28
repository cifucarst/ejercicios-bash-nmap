#!/bin/bash

# Ejercicio 1: Escaneo de puertos con Nmap

# Objetivo: Utilizar Nmap para escanear los puertos de una máquina remota.

# Pasos:

#     Ejecuta un escaneo de puertos en una máquina remota (por ejemplo, 192.168.1.1) 
#     utilizando Nmap.
#     Muestra los resultados en la pantalla para ver qué puertos están abiertos.

#!/bin/bash

# Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"

# Manejo de señales Ctrl+C
function ctrl_c(){
    echo -e "\n\n\t${redColour}[!] Saliendo inesperadamente ...${endColour}"
    tput cnorm
    exit 1
}
trap ctrl_c INT

# Obtener IP
function obtenerIP(){
    local ip=$(hostname -I | cut -d ' ' -f 1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.')
    ip+="1/24"
    echo "$ip"
}

# Escanear Puertos con Nmap
function escanearPuertos(){
    tput civis
    local ip=$(obtenerIP)
    
    # Validar la dirección IP antes de usarla
    if [[ ! $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/24$ ]]; then
        echo -e "\n${redColour}[!] Error: Dirección IP no válida.${endColour}\n"
        tput cnorm
        exit 1
    fi

    nmap --top-ports 500 --open $ip | grep "open"
}

# Ejecutar el escaneo de puertos
escanearPuertos
tput cnorm