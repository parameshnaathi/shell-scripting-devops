#!/bin/bash

##########
#$1   = first column
#$2   = second column
#$NF  = last column
#$0   = entire line
#NR   = current line number
#NF   = number of fields
##########

echo "========== TOP AWK COMMANDS =========="

# 1. Print a specific column
awk '{print $1}' file.txt

# 2. Print multiple columns
awk '{print $1, $3}' file.txt

# 3. Use a custom delimiter
awk -F: '{print $1}' /etc/passwd

# 4. Filter rows based on a condition
awk '$3 > 80 {print $1, $3}' usage.txt

# 5. Print line numbers with content
awk '{print NR, $0}' file.txt


echo
echo "========== TOP SED COMMANDS =========="

# 1. Replace first occurrence in each line
sed 's/ERROR/WARN/' file.txt

# 2. Replace all occurrences
sed 's/ERROR/WARN/g' file.txt

# 3. Delete lines containing a pattern
sed '/DEBUG/d' application.log

# 4. Print a specific range of lines
sed -n '10,20p' file.txt

# 5. Replace text directly inside the file
sed -i 's/old/new/g' file.txt
