#!/bin/bash

script="${0##*/}"

	echo "
		1 - Hvem er jeg og hva er navnet p˚a dette scriptet?
		2 - Hvor lenge er det siden siste boot?
		3 - Hvor mange prosesser og tråder finnes?
		4 - Hvor mange context switch'er fant sted siste sekund?
		5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
		6 - Hvor mange interrupts fant sted siste sekund?
		9 - Avslutt dette scriptet 
	"
	while [ "$svar" != 9 ]
	do
	
	echo "Velg en funksjon: "
	read svar

	case $svar in 
		1) 
       		echo "Jeg er Zohaib. Scriptet heter $script"   
			;;
		2)
			 echo "Siste boot: $(uptime -p)"		
			;;
		3)
			echo "Det finnes $(ps auxh -T | wc -l)"
			;;
		4)
			contextSwitch=$(grep ctxt /proc/stat | awk '{print $2}')
			sleep 1
			currentContextSwitch=$(grep ctxt /proc/stat | awk '{print $2}')
			echo "Det har vært $((currentContextSwitch - contextSwitch)) context switch" 
			;;
		5)	
			# Black magic
			userMode=$(grep cpu -m 1 /proc/stat | awk '{print $2}')
			kernelMode=$(grep cpu -m 1 /proc/stat | awk '{print $4}')
			sleep 1
			currentUserMode=$(grep cpu -m 1 /proc/stat | awk '{print $2}')
			currentKernelMode=$(grep cpu -m 1 /proc/stat | awk '{print $4}')
			
			# Calculating cpu usage within last second
			diffUserMode=$((currentUserMode - userMode))
			diffKernelMode=$((currentKernelMode - kernelMode))

			# total cpu
			sum=$((diffUserMode + diffKernelMode))
			# percentage of total cpu usage
			prosent=$((sum * 100))

			echo "Det har vært $(echo "scale=2; $diffUserMode / ($diffUserMode + $diffKernelMode) * 100" | bc)% context switch i user mode og $(echo "scale=2; $diffKernelMode / ($diffUserMode + $diffKernelMode) * 100" | bc)% context switch i kernel mode" 
			;;
		6)
			interrupts=$(grep intr /proc/stat | awk '{print $2}')
			sleep 1
			currentInterrupts=$(grep intr /proc/stat | awk '{print $2}')
			
			echo "Det har vært $((currentInterrupts - interrupts)) interrupts"
			;;
	esac
done