#!/bin/bash

clear && printf '\e[3J'

echo "Installation de SQL Server 2019 sur Ubuntu"

Name="MSS-2019-latest"
IdImage="2019-latest"

echo ""
echo "Téléchargement de la dernière version de SQL Server 2019 à partir de l'image $IdImage :"
echo ""

docker pull mcr.microsoft.com/mssql/server:$IdImage

echo ""
echo "STOP : "

docker container stop $Name


echo ""
echo "REMOVE  : "

docker container rm $Name

echo ""
echo "Creation de la base de données local (avec user 'sa') : "

SAPassword="UCwXdVHgWb3JrZGrvytMWqQgsakDVyKpsPuz5SB6"

docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=$SAPassword -e MSSQL_PID=Express -p 1433:1433 --name $Name -d mcr.microsoft.com/mssql/server:$IdImage

echo ""
echo "SQL Server installé !"
echo ""
echo "LOGIN : sa"
echo "PASSWORD : $SAPassword"


