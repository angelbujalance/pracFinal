#!/usr/bin/awk -f

#Nombre y apellidos del alumno: Angel Bujalance Gómez

#Usuario de la UOC del alumno: abujalancegom

#Fecha:28/05/2023

#OBJETIVO DEL SCRIPT: Automatizar la limpieza de datos para los casos de
#de covid.

#Nombre, tipo y número de línea o líneas donde se realiza la manipulación:
# RegEx (26); selecciona los registros de positivos en COVID
# Split (29,30); cambia el formato de la fecha a YYYY-MM-DD
# arr_women_cases_march_20 (arr) (36,38); positivos de mujeres en Marzo'20
# arr_men_cases_march_20 (arr) (40,42); positivos de hombres en Marzo'20
# women_sum (int) (53-55); suma los casos de mujeres marzo '20
# men_sum (int) (60-62); suma los casos de hombres marzo '20


#the columns in the file are separated by ","
BEGIN {FS=","; OFS=","}

#de totes les dades, seleccionam aquells registres
#que son casos positius de covid]
/^[^,]*,[^,]*,[^,]*,Positiu.*,/ {

    #canviar el dateformat de DD/MM/YYYY a YYYY-MM-DD
    split($1, date, "/")
    $1 = date[3] "-" date[2] "-" date[1]

    #printf($1, $2, $3, $4, $5) >> "data_cleaned.csv"
    print >> "data_cleaned.csv"

    #comprueba si los registros son de marzo '20 y de mujeres
    if ($3 == "Dona" && $1 ~ /^2020-03-[0-9]{2}/) {
        #almacena los casos en una array
        arr_women_cases_march_20[NR] = int($5)
    #comprueba si los registros son de marzo '20 y de hombres
    } else if ($3 == "Home" && $1 ~ /^2020-03-[0-9]{2}/) {
        #almacena los casos en una array
        arr_men_cases_march_20[NR] = int($5)
    }
}


END {

  women_sum = 0
  men_sum = 0

  #suma los casos en marzo '20 de mujeres
  for (i in arr_women_cases_march_20) {
    if (arr_women_cases_march_20[i] > 0) {
      women_sum += arr_women_cases_march_20[i]
    }
  }

  #suma los casos en marzo '20 de hombres
  for (i in arr_men_cases_march_20) {
    if (arr_men_cases_march_20[i] > 0) {
      men_sum += arr_men_cases_march_20[i]
    }
  }

  #imprime por pantalla los resultados
  print("Cases in March 2020")
  print("Women Cases\tDaily Avg W\tMen Cases\tDaily Avg M")
  printf("%d\t\t%.4f\t%d\t\t%.4f\n", women_sum, women_sum/31, men_sum, men_sum/31)
}
