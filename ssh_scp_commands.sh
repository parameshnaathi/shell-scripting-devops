#!/bin/bash

echo "========== TOP SSH COMMANDS =========="

# 1. Connect to a remote server
ssh user@server_ip

# 2. Connect using a specific port
ssh -p 2222 user@server_ip

# 3. Connect using a private key
ssh -i ~/.ssh/id_rsa user@server_ip

# 4. Execute a command remotely
ssh user@server_ip "df -h"

# 5. Copy your public SSH key to remote server
ssh-copy-id user@server_ip


echo
echo "========== TOP SCP COMMANDS =========="

# 1. Copy local file to remote server
scp file.txt user@server_ip:/tmp/

# 2. Copy remote file to local machine
scp user@server_ip:/tmp/file.txt .

# 3. Copy directory recursively
scp -r myapp/ user@server_ip:/opt/

# 4. Copy file from one remote server to another remote server
scp user1@server1:/tmp/app.log user2@server2:/backup/

# 5. Copy using a private SSH key
scp -i ~/.ssh/id_rsa file.txt user@server_ip:/tmp/


echo
echo "========== EXTRA IMPORTANT SCP COMMAND =========="

# Copy using a specific SSH port
# Note: SCP uses uppercase -P
scp -P 2222 file.txt user@server_ip:/tmp/
