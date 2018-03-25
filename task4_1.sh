#!/bin/bash
echo '--- Hardware ---'
echo "CPU:" `dmidecode -s processor-version | uniq `
echo "RAM:" `free -m -h | grep Mem | cut -d":" -f2 | awk '{print $1}'`
echo "Motherboard:" `dmidecode -s baseboard-product-name`
echo "System Serial Number:" `dmidecode -s system-serial-number`
echo '--- System ---'
echo "OS Distribution:" `lsb_release -d -s`
echo "Kernel version:" `uname -r`
echo "Installation date:" `ls -lct /etc | tail -1 | awk '{print $6,$7,$8}'`
echo "Hostname:" `hostname`
echo "Uptime:" `uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo "Processes running:" `ps -e | wc -l`
echo "User logged in:" `who | wc -l`
echo '--- Network ---'

