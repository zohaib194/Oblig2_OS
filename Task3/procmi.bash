#!/bin/bash

currentDate=$(date +"%y%m%d-%H:%M:%S")

if [[ "$#" -gt 0 ]]; then
		#statements
	for i in "$@"; do
		#statements
		fileName="$i"-"$currentDate".meminfo

		VmSize=$(grep VmSize -m 1 /proc/"$i"/status | awk '{print$2,$3}')
		VmData=$(grep VmData -m 1 /proc/"$i"/status | awk '{print$2}')
		VmStk=$(grep VmStk -m 1 /proc/"$i"/status | awk '{print$2}')
		VmExe=$(grep VmExe -m 1 /proc/"$i"/status | awk '{print$2}')
		VmLib=$(grep VmLib -m 1 /proc/"$i"/status | awk '{print$2,$3}')
		VmRSS=$(grep VmRSS -m 1 /proc/"$i"/status | awk '{print$2,$3}')
		VmPTE=$(grep VmPTE -m 1 /proc/"$i"/status | awk '{print$2,$3}')

		{
			echo "******** Minne info om prosess med PID $i ********"
			echo "Total bruk av virtuelt minne (VmSize):	$VmSize"
			echo "Mengde privat virtuelt minne (VmData+VmStk+VmExe):	$((VmData+VmStk+VmExe)) kB"
			echo "Mengde shared virtuelt minne (VmLib):    $VmLib"
			echo "Total bruk av fysisk minne (VmRSS):	$VmRSS"
			echo "Mengde fysisk minne som benyttes til page table (VmPTE):    $VmPTE"
		} > "$fileName"
	done
else 
	echo "Minst 1 parameter $#"	
fi