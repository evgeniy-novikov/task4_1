#!/bin/bash
touch task4_1.out
echo '--- Hardware ---' >> task4_1.out
echo "CPU:" `dmidecode -s processor-version | uniq ` >> task4_1.out
echo "RAM:" `free -m -h | grep Mem | cut -d":" -f2 | awk '{print $1}'` >> task4_1.out
echo "Motherboard:" `dmidecode -s baseboard-product-name` >> task4_1.out
echo "System Serial Number:" `dmidecode -s system-serial-number` >> task4_1.out
echo '--- System ---' >> task4_1.out
echo "OS Distribution:" `lsb_release -d -s` >> task4_1.out
echo "Kernel version:" `uname -r` >> task4_1.out
echo "Installation date:" `ls -lct /etc | tail -1 | awk '{print $6,$7,$8}'` >> task4_1.out
echo "Hostname:" `hostname` >> task4_1.out
echo "Uptime:" `uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'` >> task4_1.out
echo "Processes running:" `ps -e | wc -l` >> task4_1.out
echo "User logged in:" `who | wc -l` >> task4_1.out
echo '--- Network ---' >> task4_1.out

