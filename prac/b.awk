#!/usr/bin/awk -f

#Nombre y apellidos del alumno: Angel Bujalance Gómez

#Usuario de la UOC del alumno: abujalancegom

#Fecha:24/06/2023

#OBJETIVO DEL SCRIPT: Estudiar la estacionalidad del COVID.

# Durante la epidemia se debatió si el COVID tenía un componente estacional.
# Si es así, esperaremos más casos en los meses de invierno que en el resto.

# Como en el 2020 hubo el confinamiento y la pandemia no llegó a España hasta
# finales del iniverno de 2020, se contabilizarán los registros de 2021 y 2022.

#Nombre, tipo y número de línea o líneas donde se realiza la manipulación:

# RegEx (34); selecciona los registros de positivos en BCN en 2021 y 2022

# If condition (35,37); guarda los positivos si son de Enero a Marzo
#	en una array, excepto los que son por test rápido

# Else if condition (39,49); repite el proceso para los otros meses
#       en una array, excepto los que son por test rápido

# wtr_sum (int) (61-63); suma los positivos de Ene-Mar

# season_sum (int) (68-84); se suman los positivos para las demás estaciones

#the columns in the file are separated by ","
BEGIN {FS=","; OFS=","}

/^202[1-2]-[0-9]*-[0-9]*,BARCELONA/ { #positive cases years 2021 and 2022 in BCN
    if ($1 ~ /^202[1-2]-0[1-3]/ && $4 != "Positiu per Test Ràpid") { #winter
        #almacena los casos en una array
        arr_winter_cases[NR] = int($5)
    }
    else if ($1 ~ /^202[1-2]-0[4-6]/ && $4 != "Positiu per Test Ràpid") { #spring
        #almacena los casos en una array
        arr_spring_cases[NR] = int($5)
    }
    else if ($1 ~ /^202[1-2]-0[7-9]/ && $4 != "Positiu per Test Ràpid") { #summer
        #almacena los casos en una array
        arr_summer_cases[NR] = int($5)
    }
    else if ($1 ~ /^202[1-2]-1[0-2]/ && $4 != "Positiu per Test Ràpid") { #autumn
        #almacena los casos en una array
        arr_autumn_cases[NR] = int($5)
    }
}

END {

  wntr_sum = 0
  sprg_sum = 0
  smmr_sum = 0
  atmn_sum = 0

  #suma los casos de enero a marzo
  for (i in arr_winter_cases) {
    if (arr_winter_cases[i] > 0) {
      wntr_sum += arr_winter_cases[i]
    }
  }

  #suma los casos de abril a junio
  for (i in arr_spring_cases) {
    if (arr_spring_cases[i] > 0) {
      sprg_sum += arr_spring_cases[i]
    }
  }

  #suma los casos de julio a septiembre
  for (i in arr_summer_cases) {
    if (arr_summer_cases[i] > 0) {
      smmr_sum += arr_summer_cases[i]
    }
  }

  #suma los casos de octubre a diciembre
  for (i in arr_autumn_cases) {
    if (arr_autumn_cases[i] > 0) {
      atmn_sum += arr_autumn_cases[i]
    }
  }

  #imprime por pantalla los resultados
  print("Cases by Period of Time")
  print("Cases from January to March:\t" wntr_sum)
  print("Cases from April to June:\t" sprg_sum)
  print("Cases from July to September:\t" smmr_sum)
  print("Cases from October to December:\t" atmn_sum)
}
