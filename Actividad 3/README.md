# ACTIVIDAD 3 - Error nginx

Cuando se carga la aplicación ```react.js```, el enrutador de react maneja las rutas en la interfaz. Digamos, por ejemplo, que está en ```http://a.com```. Luego, en la página, navega a ```http://a.com/b```. Este cambio de ruta se maneja en el propio navegador. 

Ahora, cuando actualiza o abre la URL ```http://a.com/b``` en una nueva pestaña, la solicitud va a nginx donde la ruta en particular no existe y, por lo tanto, obtiene 404.

Para evitar esto, se debe cargar el archivo raíz (generalmente ```index.html```) para todas las rutas que no coincidan, de modo que nginx envíe el archivo raiz y la ruta sea manejada por la aplicación de react en el navegador.

Esto se puede hacer con un archivo ```nginx.conf```, este llevaria lo siguiente

```
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        try_files $uri /index.html;                 
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

Este archivo contiene configuracion básica de nginx, como el nombre del servidor y el puerto donde escuchará peticiones. Ademas, este configura la ubicacion del archivo raiz ```index.html``` para hacer que nginx deje al navegador manejar las peticiones de las rutas que no coincidan.

Luego lo unico que se tendra que hacer es copiar este archivo en el ```dockerfile``` de nginx para que este arvhivo de configuracion este presente en la imagen.

```
COPY nginx.conf /etc/nginx/conf.d/default.conf
```
