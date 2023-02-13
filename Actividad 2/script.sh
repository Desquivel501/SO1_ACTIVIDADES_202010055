
#!/usr/bin/env bash

set -o nounset
set -o pipefail
set -o errexit 

echo "Ingrese su nombre de usuario: "
read GITHUB_USER

content=$(curl -s "https://api.github.com/users/$GITHUB_USER")
message=$(echo "${content}"| jq -r '.message')

if [[ $message != "null" ]]; then
    echo "El usuario no existe"

else
    username=$(echo "${content}"| jq -r '.login')
    creation_date=$(echo "${content}"| jq -r '.created_at')
    user_id=$(echo "${content}"| jq -r '.id')

    exec_date=$(date +'%d-%m-%Y %T')

    echo Hola $GITHUB_USER. User ID: $user_id. Cuenta fue creada el: $creation_date.

    mkdir -p /tmp/"$exec_date"

    echo Hola $GITHUB_USER. User ID: $user_id. Cuenta fue creada el: $creation_date. > /tmp/"$exec_date"/saludos.log
fi
