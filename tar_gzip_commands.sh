#!/bin/bash

echo "========== TOP 5 TAR / GZIP COMMANDS =========="

# 1. Create a tar backup of a directory
tar -cvf backup.tar test/

# 2. Create a compressed tar.gz backup
tar -czvf backup.tar.gz test/

# 3. Extract a tar.gz backup
tar -xzvf backup.tar.gz

# 4. Compress a single large file using gzip
gzip application.log

# 5. Decompress a .gz file
gunzip application.log.gz
