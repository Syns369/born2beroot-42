#!/bin/bash

ARCH=$(uname --all)
pCPU=$(grep "physcal id" /proc/cpuinfo | sort | uniq | wc -l)
vCPU=$(grep "processor" /proc/cpuinfo | wc -l)
MemU=$(free --mega | grep Mem | awk '{printf("%i/%iMB (%.2f%%)\n", $3, $2, $3/$2*100)}')
DU=$(df --total -h | grep "total" | awk '{printf("%s/%s (%.1f%%)\n", $3, $2, $3/$2*100)}')
CPUl=$(top -bn1 | grep "%Cpu" | awk '{printf("%.1f%%\n", (100.0*$8)%100)}')
LBoot=$(who --boot | awk '{printf("%s %s", $3, $4)}')
LVMu=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
cTCP=$(ss -s | grep "TCP:" | tr ',' ' ' | awk '{printf("%s ESTABLISHED\n", $4)}')
Userl=$(who --count | grep "users" | tr '=' ' ' | awk '{printf("%s\n", $3)}')
IP=$(echo IP $(hostname -I))
NET=$(ip link | grep "ether" | awk '{print($2)}')
SUDO=$(sudo ls /var/log/sudo/00/00 | wc -l)

wall	"#Architecture: $ARCH
	#CPU physical: $pCPU
	#vCPU: $vCPU
	#Memory Usage: $MemU
	#Disk Usage: $DU
	#CPU load: $CPUl
	#Last boot: $LBoot
	#LVM use: $LVMu
	#Connexions TCP: $cTCP
	#User log: $Userl
	#Network: $IP ($NET)
	#Sudo: $SUDO
	"


