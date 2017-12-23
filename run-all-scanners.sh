 #!/bin/bash

echo "------ PROGRAM SKANUJĄCY ------"

export SANE_DEBUG_MUSTEK_USB=0

detected=(`scanimage -L | grep -oP '[a-z0-9]+:[a-z0-9]+:[0-9]{3}:[0-9]{3}'`)
#declare -a detected=("element1" "element2" "element3")
echo "WYKRYTYCH SKANERÓW: $detected"

additional_options=""

if [ ! -z "${2}" ]; then
	additional_options+=" --resolution ${2}"
fi

if [ ! -z "${3}" ]; then
	additional_options+=" -x ${3}"
fi

if [ ! -z "${4}" ]; then
	additional_options+=" -y ${4}"
fi

if [ ! -z "${5}" ]; then
	additional_options+=" --brightness ${5}"
fi

echo "zeskanowane obrazy zostaną umieszczone w katalogu $file_path"

i=0

date=`date +%Y-%m-%d`
time=`date +%H-%M-%S`
for scanner in "${detected[@]}"
do
   echo "staring scanning with $scanner"
   i=$((i + 1))
   echo "${1}/${date}_skaner${i}_${time}.pnm"
   eval "scanimage -d $scanner $additional_options > ${1}/${date}_skaner${i}_${time}.pnm"
done
