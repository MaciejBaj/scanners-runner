 #!/bin/bash

echo "------ PROGRAM SKANUJĄCY ------"

export SANE_DEBUG_MUSTEK_USB=0

detected=(`scanimage -L | grep -oP '[a-z0-9]+:[a-z0-9]+:[0-9]{3}:[0-9]{3}'`)

echo "WYKRYTYCH SKANERÓW: $detected" 

for scanner in "${detected[@]}"
do
   echo "staring scanning with $scanner"
   date=`date +%Y-%m-%d\ %H-%M-%S` 
   file_path="/home/macio/Pulpit/skany/$date.pnm"
   echo $file_path
   `scanimage --device=$scanner > "$file_path"`
done
