#!/bin/bash

echo "========== TOP 5 FIND COMMANDS =========="

# 1. Find a file by name
find /tmp -name "test.txt"

# 2. Find all .log files
find /var/log -type f -name "*.log"

# 3. Find files larger than 100 MB
find / -type f -size +100M 2>/dev/null

# 4. Find files modified in last 24 hours
find . -type f -mtime -1

# 5. Find and delete .tmp files
find . -type f -name "*.tmp" -delete


echo
echo "========== TOP 5 GREP COMMANDS =========="

# 1. Search for ERROR in a file
grep "ERROR" application.log

# 2. Case-insensitive search
grep -i "error" application.log

# 3. Search recursively in a directory
grep -r "ERROR" /var/log 2>/dev/null

# 4. Show matching line numbers
grep -n "ERROR" application.log

# 5. Search multiple patterns
grep -E "ERROR|WARN|FATAL" application.log
