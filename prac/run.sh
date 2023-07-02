#!/bin/bash

#master script to excecute the full project
echo -e "\n\n-------------------\nExcecution script a.sh:\n"
./a.sh

echo -e "\n\n-------------------\nExcecution script b1.awk:\n"
gawk -f b1.awk covid_barcelona.csv

echo -e "\n\n-------------------\nExcecution script b.awk:\n"
gawk -f b.awk data_cleaned.csv

echo -e "\n\n-------------------\nExcecution script c.awk:\n"
gawk -f c.awk data_cleaned.csv
