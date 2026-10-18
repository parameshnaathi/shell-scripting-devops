#!/bin/bash

echo "========== TOP CHMOD COMMANDS =========="

# 1. Give execute permission to a script
chmod +x script.sh

# 2. Owner: read/write/execute, Group & Others: read/execute
chmod 755 script.sh

# 3. Owner: read/write, Group & Others: read only
chmod 644 file.txt

# 4. Remove write permission from others
chmod o-w file.txt

# 5. Change permissions recursively for a directory
chmod -R 755 /opt/myapp


echo
echo "========== TOP CHOWN COMMANDS =========="

# 1. Change file owner
chown paramesh file.txt

# 2. Change owner and group
chown paramesh:devops file.txt

# 3. Change only the group
chown :devops file.txt

# 4. Change ownership recursively
chown -R paramesh:devops /opt/myapp

# 5. Copy ownership from another file
chown --reference=file1.txt file2.txt
