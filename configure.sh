#!/bin/bash
set -e
set -x
./setup_redsocks.sh 
sudo ./iptables.sh iptables 
./iptables.sh 
