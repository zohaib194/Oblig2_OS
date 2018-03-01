#!/bin/bash
# array.bash

program=($(pgrep chrome))

for i in "${program[@]}"; do

checkPageFault=$(ps --no-headers -o maj_flt	"$i")

	#statements
	if [[ "$checkPageFault" -gt 1000 ]]; then
		#statements
		echo "Chrome $i har forårsaket $checkPageFault major page faults (mer enn 1000!)"
	else
		echo "Chrome $i har forårsaket $checkPageFault major page faults"
	fi

done