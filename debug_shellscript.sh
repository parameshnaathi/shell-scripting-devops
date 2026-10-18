#!/bin/bash

############
#Author : Paramesh Nathi
#Version :V1.0.0
#Problem Description : How do you debug a shell script?
############
#set -euo pipefail
#-e → exit on command failure
#-u → error on undefined variables
#pipefail → fail a pipeline when any command fails

set -x

name="Paramesh"
echo "$name"

set +x
