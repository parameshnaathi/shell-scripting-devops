```bash
#!/bin/bash

###############################################################################
# Script Name : disk_utilization_check.sh
# Author      : Paramesh Nathi
# Purpose     : Demonstrate common Linux disk space and disk utilization checks
#               in a single script for SRE / DevOps interview practice.
#
# Concepts Covered:
# 1. Overall filesystem disk usage using df
# 2. Human-readable disk usage
# 3. Specific filesystem usage percentage
# 4. Directory-level disk utilization using du
# 5. Top largest directories
# 6. Top largest files
# 7. Files larger than a specific size
# 8. Disk usage threshold alert
# 9. Inode utilization
# 10. /var/log utilization
# 11. Mounted filesystems
# 12. Files deleted but still consuming disk space
###############################################################################

echo "=========================================================="
echo "1. OVERALL FILESYSTEM DISK SPACE USAGE"
echo "=========================================================="

# df = disk filesystem
# -h = human-readable format such as MB, GB, TB
#
# This shows:
# Filesystem
# Total size
# Used space
# Available space
# Usage percentage
# Mount point

df -h

echo
echo "=========================================================="
echo "2. ROOT FILESYSTEM DISK USAGE"
echo "=========================================================="

# Check only the root filesystem /
#
# This is commonly used during production incidents when somebody says:
# "Server disk utilization is high."

df -h /

echo
echo "=========================================================="
echo "3. ROOT FILESYSTEM USAGE PERCENTAGE ONLY"
echo "=========================================================="

# df -P:
# POSIX output format. This makes parsing with awk more predictable.
#
# NR==2:
# Skip the header and process only the second line.
#
# $5:
# Fifth column contains percentage used, for example 75%.
#
# gsub("%","",$5):
# Removes the % symbol so we can use the value in arithmetic comparisons.

ROOT_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Root filesystem utilization is: ${ROOT_USAGE}%"

echo
echo "=========================================================="
echo "4. DIRECTORY-LEVEL DISK UTILIZATION"
echo "=========================================================="

# df tells us filesystem usage.
# du tells us how much space files/directories consume.
#
# -s = summary
# -h = human-readable

echo "Disk usage of /var directory:"
du -sh /var 2>/dev/null

echo
echo "Disk usage of /var/log directory:"
du -sh /var/log 2>/dev/null

echo
echo "Disk usage of current directory:"
du -sh .

echo
echo "=========================================================="
echo "5. TOP 10 LARGEST DIRECTORIES UNDER /var"
echo "=========================================================="

# du -x:
# Stay within the same filesystem.
#
# du -h:
# Human-readable sizes.
#
# --max-depth=1:
# Only inspect directories one level below /var.
#
# sort -hr:
# Sort human-readable sizes in reverse order.
# Largest entries appear first.
#
# head -10:
# Show only the top 10.

du -xh --max-depth=1 /var 2>/dev/null | sort -hr | head -10

echo
echo "=========================================================="
echo "6. TOP 10 LARGEST ITEMS IN /var/log"
echo "=========================================================="

# Useful when /var/log becomes very large.
#
# This helps identify which application or logfile is consuming most space.

du -ah /var/log 2>/dev/null | sort -hr | head -10

echo
echo "=========================================================="
echo "7. TOP 10 LARGEST FILES ON THE SYSTEM"
echo "=========================================================="

# find /:
# Search from root filesystem.
#
# -xdev:
# Do not cross into other mounted filesystems.
#
# -type f:
# Search only regular files.
#
# -printf '%s %p\n':
# Print file size in bytes and full path.
#
# sort -nr:
# Sort numerically, largest first.
#
# head -10:
# Show top 10 largest files.
#
# 2>/dev/null:
# Hide permission-denied errors.

find / -xdev -type f -printf '%s %p\n' 2>/dev/null \
    | sort -nr \
    | head -10

echo
echo "=========================================================="
echo "8. FIND FILES LARGER THAN 1 GB"
echo "=========================================================="

# -size +1G:
# Find files whose size is greater than 1 GB.
#
# Very useful during disk-full troubleshooting.

find / -xdev -type f -size +1G 2>/dev/null

echo
echo "=========================================================="
echo "9. CHECK DISK UTILIZATION AGAINST THRESHOLD"
echo "=========================================================="

# In production, SRE teams normally configure monitoring tools such as:
# Datadog
# Prometheus
# CloudWatch
# Azure Monitor
#
# But shell scripting can also perform a basic threshold check.

THRESHOLD=80

CURRENT_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

if (( CURRENT_USAGE >= THRESHOLD ))
then
    echo "ALERT: Root filesystem utilization is ${CURRENT_USAGE}%"
    echo "Threshold is ${THRESHOLD}%"
else
    echo "OK: Root filesystem utilization is ${CURRENT_USAGE}%"
    echo "Threshold is ${THRESHOLD}%"
fi

echo
echo "=========================================================="
echo "10. CHECK ALL FILESYSTEMS ABOVE 80%"
echo "=========================================================="

# df -P:
# Produces predictable output.
#
# NR>1:
# Ignore the header.
#
# For every filesystem:
# Remove percentage symbol.
# If usage >= 80, print an alert.

df -P | awk '
NR > 1 {
    usage=$5
    gsub("%","",usage)

    if (usage >= 80) {
        print "ALERT:", $1, "mounted on", $6, "is", usage "% full"
    }
}'

echo
echo "=========================================================="
echo "11. INODE UTILIZATION"
echo "=========================================================="

# Sometimes df -h shows free disk space, but users still cannot create files.
#
# One possible reason:
# The filesystem has exhausted all available inodes.
#
# Every file/directory normally consumes an inode.
#
# df -i:
# Displays inode utilization.

df -i

echo
echo "=========================================================="
echo "12. ROOT FILESYSTEM INODE USAGE"
echo "=========================================================="

df -i /

echo
echo "=========================================================="
echo "13. DISPLAY MOUNTED FILESYSTEMS"
echo "=========================================================="

# lsblk:
# Shows block devices, partitions and mount points.
#
# Useful for understanding disk layout.

lsblk

echo
echo "=========================================================="
echo "14. FILESYSTEM TYPE AND MOUNT DETAILS"
echo "=========================================================="

# df -Th:
# -T = display filesystem type
# -h = human-readable
#
# Example filesystem types:
# ext4
# xfs
# tmpfs
# overlay

df -Th

echo
echo "=========================================================="
echo "15. CHECK LARGE LOG FILES"
echo "=========================================================="

# Check largest log files under /var/log.
#
# This is extremely common in production troubleshooting.

find /var/log -type f -printf '%s %p\n' 2>/dev/null \
    | sort -nr \
    | head -10

echo
echo "=========================================================="
echo "16. CHECK DELETED FILES STILL CONSUMING DISK SPACE"
echo "=========================================================="

# Important production scenario:
#
# A logfile may be deleted using rm, but if a running process still has
# the file open, Linux does not immediately release the disk space.
#
# lsof +L1:
# Lists open files whose link count is less than 1,
# meaning deleted files still held open by processes.
#
# Not every corporate machine has lsof installed.

if command -v lsof >/dev/null 2>&1
then
    lsof +L1
else
    echo "lsof command is not installed or not available."
fi

echo
echo "=========================================================="
echo "17. QUICK DISK TROUBLESHOOTING SUMMARY"
echo "=========================================================="

echo "Filesystem usage:"
df -h /

echo
echo "Largest directories under /var:"
du -xh --max-depth=1 /var 2>/dev/null | sort -hr | head -5

echo
echo "Largest items under /var/log:"
du -ah /var/log 2>/dev/null | sort -hr | head -5

echo
echo "Inode usage:"
df -i /

echo
echo "Disk utilization check completed."
```

