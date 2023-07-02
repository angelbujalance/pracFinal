 #!/usr/bin/awk -f

#Nombre y apellidos del alumno: Angel Bujalance Gómez

#Usuario de la UOC del alumno: abujalancegom

#Fecha:28/06/2023

#OBJETIVO DEL SCRIPT: Agrupar los casos positivos independientemente del test utilizado por mes y año.

#Nombre y tipo de los campos de emtrada:
#Date (fecha), City (string), Test (String), Cases (entero)

#Operaciones y nº línea o líneas donde se realizan: split (25);
#asignar valor a variable (29-31); agrupación (34,35,39-41)

#Nombre y tipo de los nuevos campos generados:
#Year (entero), Month (entero), City (string), sex (string), Positives (entero)


#the columns in the file are separated by ","
BEGIN {FS=","; OFS=","}

{

    split($1, date, "-")

    #extract the year and the month from the date
    year = date[1]
    month = date[2]
    city = $2
    sex = $3

    groupby_values = year "," month "," city "," sex
    arr[groupby_values] += $5
}

END {
    print "Year,Month,City,Sex,Positives" >> "covid_agg_data.txt"
    for (groupby_values in arr) {
        print groupby_values, arr[groupby_values] >> "covid_agg_data.txt"
    }
}
