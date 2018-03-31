#!/bin/bash
echo '--- Hardware ---' >task4_1.out
echo "CPU:" `dmidecode -s processor-version | uniq `>>task4_1.out
echo "RAM:" `free -m -h | grep Mem | cut -d":" -f2 | awk '{print $1}'`>>task4_1.out
echo "Motherboard:" `dmidecode -s baseboard-product-name`>>task4_1.out
echo "System Serial Number:" `dmidecode -s system-serial-number`>>task4_1.out
echo '--- System ---'>>task4_1.out
echo "OS Distribution:" `lsb_release -d -s`>>task4_1.out
echo "Kernel version:" `uname -r`>>task4_1.out
echo "Installation date:" `ls -lct /etc | tail -1 | awk '{print $6,$7,$8}'`>>task4_1.out
echo "Hostname:" `hostname -f`>>task4_1.out
echo "Uptime:" `uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6;else { if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}}{print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`>>task4_1.out
echo "Processes running:" `ps -e | wc -l`>>task4_1.out
echo "User logged in:" `who | wc -l`>>task4_1.out
echo '--- Network ---'>>task4_1.out

net_if_net=`ip -o -4 a l | awk '{print $2, $4}' `
#net_if=`ip a | awk '{ if ($1 ~ /^[0-9]+:/) printf $2" "; else {if ($1=="inet") print $2;}}'`
net_if=`ip a | awk '/(mtu|inet)/{ if ($1 ~ /^[0-9]+:/) $2="#"$2; printf $2",";} ' | sed -e "s/:,/: /g" -e "s/#/\n/g" | sed "s/,$//" | sed "s/ $/ -/" | sed "s/,(.*)$//"| grep -v "^$"`

 IFS=$'\n'
    for i in $net_if
        do
	echo $i>>task4_1.out
    done