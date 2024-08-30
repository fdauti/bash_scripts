#!/bin/bash
echo -e "\e[32mSync cloning-source..\e[0m"
rsync -avz 172.28.105.100:/etc /backup/incremental/cloning-source/
