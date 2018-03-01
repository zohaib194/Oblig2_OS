#!/bin/bash

currentDate=$(date +"%Y%m%d")
currentTime=$(date | awk '{print$4}')
for i in $*; do
	#statements
	fileName=($i-$currentDate-$currentTime.meminfo)
	VmSize=$(grep VmSize -m 1 /proc/$i/status | awk '{print$2,$3}')
	VmData=$(grep VmData -m 1 /proc/$i/status | awk '{print$2}')
	VmStk=$(grep VmStk -m 1 /proc/$i/status | awk '{print$2}')
	VmExe=$(grep VmExe -m 1 /proc/$i/status | awk '{print$2}')
	VmLib=$(grep VmLib -m 1 /proc/$i/status | awk '{print$2,$3}')
	VmRSS=$(grep VmRSS -m 1 /proc/$i/status | awk '{print$2,$3}')
	VmPTE=$(grep VmPTE -m 1 /proc/$i/status | awk '{print$2,$3}')
	
	echo $(echo "******** Minne info om prosess med PID $i ********" >> "$fileName")
	echo $(echo "Total bruk av virtuelt minne (VmSize):		$VmSize" >> "$fileName")
	echo $(echo "Mengde privat virtuelt minne (VmData+VmStk+VmExe):		$((VmData+VmStk+VmExe)) kB" >> "$fileName")
	echo $(echo "Mengde shared virtuelt minne (VmLib):     $VmLib" >> "$fileName")
	echo $(echo "Total bruk av fysisk minne (VmRSS):	 $VmRSS" >> "$fileName")
	echo $(echo "Mengde fysisk minne som benyttes til page table (VmPTE):	 $VmPTE" >> "$fileName")



done