#!/bin/bash

echo '--- Hardware ---' >task4_1.out
add_string(){
    echo "$1" >> task4_1.out
    return 0
};

CPU=`dmidecode -s processor-version | uniq `
add_string "CPU: $CPU"

RAM=`free -m -h | grep Mem | cut -d":" -f2 | awk '{print $1}'`
add_string "RAM: $RAM"

Motherboard=`dmidecode -s baseboard-product-name`
if [ -z "$Motherboard" ]; then
    Motherboard="Unknown"
fi
add_string "Motherboard: $Motherboard"

SSN=`dmidecode -s system-serial-number`
if [ -z "$SSN" ]; then
    SSN="Unknown"
fi
add_string "System Serial Number: $SSN"

echo '--- System ---'>>task4_1.out

OSD=`lsb_release -d -s`
add_string "OS Distribution: $OSD"

KV=`uname -r`
add_string "Kernel version: $KV"

ID=`ls -lct /etc | tail -1 | awk '{print $6,$7,$8}'`
add_string "Installation date: $ID"

Hostname=`hostname -f`
add_string "Hostname: $Hostname"


Uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6;else { if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}}{print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
add_string "Uptime: $Uptime"

PR=`ps -e | wc -l`
add_string "Processes running: $PR"

UL=`who | wc -l`
add_string "User logged in: $UL"

echo '--- Network ---'>>task4_1.out

net_if=`ip a | awk '/(mtu|inet)/{ if ($1 ~ /^[0-9]+:/) $2="#"$2; printf $2",";} ' | sed -e "s/:,/: /g" -e "s/#/\n/g" | sed "s/,$//" | sed "s/ $/ -/" | grep -v "^$"`

 IFS=$'\n'
    for i in $net_if
        do
	echo $i |cut -d "," -f1 >>task4_1.out
    done