# Actividad 4
Esta actividad consiste en la elaboracion de un servicio de linux para saludar al usuario e imprimir la fecha actual.

----
## Creacion del script
Primero se debera escribir el script que se ejecutara en el servicio. 

Este sera un simple scipt de bash para obtener el nombre del usuario e imprimir la fecha actual.

```bash
#!/bin/bash
current_date=$(date +%d-%m-%Y %H:%M:%S)
username=$(whoami)
echo "Hola $username! La fecha de hoy es $current_date"  >> /var/log/saludo.txt
```

---

## Creacion del archivo .service
Los servicios de linux se crearan por medio de un archivo ```.service```. Este tendra la informacion y parametros de nuestro servicio.

Para escribirlo crearemos un archivo ```.service``` en la carpeta ```/etc/systemd/system```, por lo que podremos crear un nuevo archivo con el comando 

```bash
sudo nano /etc/systemd/system/<nombre>.service
```

Ahora aqui pasaremos a escribir nuestro servicio.

Se iniciara especificando la ```[Unit]```, aqui daremos una breve descripcion del servicio.

```
[Unit]
Description=Actividad 4 - 202010055
rent_date"  >> /var/log/saludo.txt
```
Luego escribiremos la funcionalidad principal de nuestro servicio en la seccion ```[Service]```. 

Lo primero sera escribir el tipo de servicio, en este caso es un serivcio simple.

```
Type=simple
```

Luego tendremos que colocar cuada cuanto se reiniciara el servicio. En este caso colocaremos que se reinice solamente si falla y probara ejecutarse nuevamente 30 segundo despues.

```
Restart=on-failure
RestartSec=30s
```
Por ultimo escribiremos que ejecutara el servicio, en este caso queremos que ejecute nuestro script de bash.

```
ExecStart=/bin/bash /home/derekesquivel/Documentos/script.sh
```

Para concluir el servicio se colocaran los parametros de installacion en ```[Install]```, en este caso queremos que se instale para todos los usuarios del dispositivo.

```
[Install]
WantedBy=multi-user.target
```

El archivo ```.service``` final quedaria de la siguiente manera.

```
[Unit]
Description=Actividad 4 - 202010055

[Service]
Type=simple
Restart=on-failure
RestartSec=30s
ExecStart=/bin/bash /home/derekesquivel/Documentos/script.sh

[Install]
WantedBy=multi-user.target
```

## Instalacion del servicio
Una vez teniendo nuestro archivo ```.service``` en la carpeta ```./etc/systemd/system```. pasaremos instalar el servicio.

Lo primero sera recargar systemd para que reconozca nuestro nuevo servicio.

```
sudo systemctl daemon-reload
```

Finalmente habilitaremos el servicio para que se ejecute en cada reboot.

```
sudo systemctl enable <nombre>.service
```
Una vez reiniciemos el dispositivo podremos ver el mensaje en el archivo que definimos.

Si todo fue hecho de manera correcta podemos usar el comando

```
sudo systemctl status <nombre>.service
```
y ver que nuestro servicio fue cargado correctamente.

```
[derekesquivel@fedora system]$ sudo systemctl status actividad4
○ actividad4.service - Actividad 4 - 202010055
     Loaded: loaded (/etc/systemd/system/actividad4.service; enabled; vendor preset: disabled)
     Active: inactive (dead) since Mon 2023-03-20 14:00:52 CST; 2min 25s ago
    Process: 6914 ExecStart=/bin/bash /home/derekesquivel/Documentos/script.sh (code=exited, status=0/SUCCESS)
   Main PID: 6914 (code=exited, status=0/SUCCESS)
        CPU: 3ms
```

Si queremos ejecutar el servicio inmediatamente en lugar de esperar a un reboot podemos usar el comando.

```
sudo systemctl start <nombre>.service
```

Hora podemos leer el archivo para ver el saludo.

```
[derekesquivel@fedora log]$ cat /var/log/saludo.txt
Hola root! La fecha de hoy es 20-03-2023 14:06:52

```