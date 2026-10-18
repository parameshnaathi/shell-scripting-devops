#!/bin/bash

############
#Author : Paramesh Nathi
#Version :V1.0.0
#Problem Description : List all ports in the system and search specific port
############

ss -lntp | grep :53
