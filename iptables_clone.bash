#!/bin/bash
#apply default rules for clone VMs
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -D FORWARD 1 #icmp restrict
iptables -D INPUT 5 #icmp restrict
iptables -D INPUT 4 #ssh allow
iptables -D INPUT 2 #icmp allow
iptables -A INPUT -p tcp -s 172.28.105.1 --dport 22 m state --state NEW -j ACCEPT
iptables -I INPUT -p icmp -s 172.28.105.0/24 -j ACCEPT
