#!/usr/bin/env python3

import nmap

def escaneo_ip_range(ips):
    result = ""

    if not ips:
        print("Debe proporcionar un rango de direcciones IP.")
        return

    # Asumiendo que el formato de ips es correcto
    nm = nmap.PortScanner()
    result = nm.scan(hosts=ips, arguments='-sV -p- -T4')

    with open('archive.txt', 'w') as file:
        file.write(str(result))

# Llama a la función proporcionando un rango de direcciones IP
escaneo_ip_range("192.168.1.1")