#!/bin/bash

echo "URL de descarga del dataset:"
url="https://raw.githubusercontent.com/angelbujalance/pracFinal/main/Registre_de_casos_de_COVID-19_Barcelones_per_sexe.csv?token=GHSAT0AAAAAACC4U524BMPGHMAKCM7GOBWAZDPYTCQ";
curl -s $url > covid_barcelona.csv #guarda los datos en un fichero .csv
echo $url

echo "Formato del fichero:"
file ./covid_barcelona.csv #muestra el tipo de fichero

echo "Columnas del fichero:"
n_cols=$(( $(head -n1 ./covid_barcelona.csv | grep -o "," | wc -l) + 1))
#método para calcular el número de cols en el fichero

echo "$n_cols"
echo "Registros del fichero:"
cat ./covid_barcelona.csv | wc -l #muestra los n registros

while getopts "v" option; do
    case $option in
      v) file="covid_barcelona.csv"

        # Selecciono una fila (3a) para obtener el tipo de cada columna
         row_data=$(sed -n "3p" "$file")

         #separo las cols, al ser .csv el separador es ","
         IFS=',' read -ra column_values <<< "$row_data"
         echo "Tipo de Dato para cada Columna:"
         # Para cada col, compruebo el tipo con una regex
         for ((i=0; i<${#column_values[@]}; i++)); do
              column_value=${column_values[$i]}
              if [[ $column_value =~ ^[0-9]+$ ]]; then
                 echo "$column_value is integer"
              elif [[ $column_value =~ ^[0-9]+\.[0-9]+$ ]]; then
                 echo "$column_value is float"
               elif [[ $column_value =~ ^[0-9]{2}/[0-9]{2}/[0-9]{4}$ ]]; then
                 echo "$column_value is date"
               else
                 echo "$column_value is text"
              fi
         done
         exit ;;
    esac
done
