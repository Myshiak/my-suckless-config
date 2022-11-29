#!/usr/bin/bash
TMPFV=$kcv
kcv=$(amixer | grep "Front Left: Capture" | tr -s ' ' | cut -d " " -f5) && \
if [[ $1 == minus ]]
then
	amixer set Capture $((kcv-6554))
else
	amixer set Capture $((kcv+6554))
fi
kcv=$TMPFV
