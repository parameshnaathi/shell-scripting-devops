#!/bin/bash

############
#Author : Paramesh Nathi
#Version :V1.0.0
#Problem Description : Sorting names [Shell has predefined sort function]
############

echo "Alphabetical order names are"
sort names.txt

echo "Reverse alphabetical order names are"
sort -r names.txt

echo "Remove duplicates"
sort -u names.txt
