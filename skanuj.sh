#!/bin/bash

#http://stackoverflow.com/questions/4880290/how-do-i-create-a-crontab-through-a-script

#/https://www.freebsd.org/cgi/man.cgi?query=gamma4scanimage&sektion=1&apropos=0&manpath=FreeBSD+8.2-RELEASE+and+Ports
detected_scanners=(`scanimage -L | grep -oP '[a-z0-9]+:[a-z0-9]+:[0-9]{3}:[0-9]{3}'`)

function start_scanning_periodically () { 
    echo "USTAWIAM SKANOWANIE O GODZINIE: ${1}:${2}" 
    hours=${1}
    minutes=${2}
		path=${3}
    dpi=${4}
    x=${5}
    y=${6}
    brightness=${7}
    `crontab -l | grep -v "bash /home/skaner/Desktop/aplikacja-skanujaca/run-all-scanners.sh $path $dpi $x $y $brightness" | crontab - && (crontab -l 2>/dev/null; echo "${minutes} ${hours} * * * bash /home/skaner/Desktop/aplikacja-skanujaca/run-all-scanners.sh $path $dpi $x $y $brightness") | crontab -`
    echo "OBECNY CRONTAB LIST:"
    crontab -l
}

export -f start_scanning_periodically

function scan_now () {
		path=${1}
    dpi=${2}
    x=${3}
    y=${4}
    brightness=${5}
    bash ./run-all-scanners.sh "$path" "$dpi" "$x" "$y" "$brightness"
}
export -f scan_now

yad \
	--form \
	--no-buttons\
	--title "Aplikacja skanująca" \
	--text "\n\n Ilość wykrytych skanerów: ${#detected_scanners[@]}. \n\n Wprowadź czas codziennego skanowania\n
	Opcje obrazu są opcjonalne. \nPodając rozdzielczość należy podać wszystkie 3 wartości: \n DPI 72, 120, 300, 600, szerokość x oraz wysokość y \nGamma w postaci \"3,4,5,6,7,8,9,10,11,12\" \nJasność od -100 do 100 % " \
	--field=" Ścieżka do zdjęć" "/home/maciej/Desktop/zdjecia" \
	--field=" Godziny" "12" \
	--field=" Minuty" "0" \
	--field=" DPI" "" \
	--field=" X" "" \
	--field=" Y" "" \
	--field=" Jasność" "100" \
	--field="Rozpocznij codzienne skanowanie o nowej godzinie:BTN" 'bash -c "start_scanning_periodically %2 %3 %1 %4 %5 %6 %7"' \
	--field="Skanuj teraz:BTN" 'bash -c "scan_now %1 %4 %5 %6 %7"'

