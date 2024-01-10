import subprocess

# Colores
green_colour = "\033[0;32m\033[1m"
end_colour = "\033[0m"
red_colour = "\033[0;31m\033[1m"

# Manejo de señales Ctrl+C
import signal
import sys

def ctrl_c(signal, frame):
    print(f"\n\n\t{red_colour}[!] Saliendo inesperadamente ...{end_colour}")
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c)

# Obtener IP
import socket

def obtener_ip():
    ip = socket.gethostbyname(socket.gethostname()).rsplit('.', 1)[0] + ".1/24"
    return ip

# Escanear Puertos con Nmap
def escanear_puertos():
    ip = obtener_ip()

    # Validar la dirección IP antes de usarla
    try:
        socket.inet_aton(ip.split('/')[0])
    except socket.error:
        print(f"\n{red_colour}[!] Error: Dirección IP no válida.{end_colour}\n")
        sys.exit(1)

    nmap_process = subprocess.Popen(['nmap', '--top-ports', '500', '--open', ip], stdout=subprocess.PIPE)
    output = nmap_process.communicate()[0].decode('utf-8')
    print(output)

# Ejecutar el escaneo de puertos
escanear_puertos()