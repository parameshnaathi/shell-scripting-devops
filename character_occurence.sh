#!/bin/bash

############
#Author : Paramesh Nathi
#Version :V1.0.0
#Problem Description : Count the number of occurrences of s in Mississippi
############

word="Mississippi"

echo "$word" | grep -oi "s" | wc -l
