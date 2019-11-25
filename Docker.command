#!/bin/bash

IDName="2017-latest-ubuntu"

echo "Affichage des containers actifs : "
echo ""

Docker ps

echo ""
echo "Téléchargement (si besoin) de la dernière version de $IDName : "
echo ""

docker pull mcr.microsoft.com/mssql/server:$IDName

echo ""
echo "Stop $IDName : "

docker container stop $IDName

echo ""
echo "Remove $IDName : "
docker container rm $IDName

echo ""

Docker ps

echo ""
echo "Creation de la base de données local (avec user 'sa') : "

SAPassword="UCwXdVHgWb3JrZGrvytMWqQgsakDVyKpsPuz5SB6"

docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=$SAPassword -e MSSQL_PID=Express -p 1433:1433 --name $IDName -d mcr.microsoft.com/mssql/server:$IDName

echo ""
echo "Test de connexion (si '1>' = OK) : "

IDDocker=$(docker ps -a -q -f name=$IDName)
docker exec -it $IDDocker /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SAPassword

