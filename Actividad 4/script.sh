#!/bin/bash
current_date=$(date +%d-%m-%Y %H:%M:%S)
username=$(whoami)
echo "Hola $username! La fecha de hoy es $current_date"  >> /var/log/saludo.txt


