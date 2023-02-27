# Database

## How to run

``` bash
docker run -d -p 1521:1521 \
-e ORACLE_PASSWORD=mipass \
-e APP_USER=appuser \
-e APP_USER_PASSWORD=miuserapp \
-v /home/jguzman/so1_containers/database:/container-entrypoint-initdb.d \
-v oradata:/opt/oracle/oradata \
gvenzl/oracle-xe:21.3.0
```
