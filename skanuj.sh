#!/bin/bash

#http://stackoverflow.com/questions/4880290/how-do-i-create-a-crontab-through-a-script

detected_scanners=(`scanimage -L | grep -oP '[a-z0-9]+:[a-z0-9]+:[0-9]{3}:[0-9]{3}'`)

function start_scanning_periodically () { 
    echo "USTAWIAM SKANOWANIE O GODZINIE: ${1}:${2}" 
    hours=${1}
    minutes=${2}
    `crontab -l | grep -v 'bash /home/macio/Pulpit/aplikacja-skanujaca/run-all-scanners.sh' | crontab - && (crontab -l 2>/dev/null; echo "${minutes} ${hours} * * * bash /home/macio/Pulpit/aplikacja-skanujaca/run-all-scanners.sh") | crontab -`
    echo "OBECNY CRONTAB LIST:"
    crontab -l
    
} 
export -f start_scanning_periodically

function scan_now () { 
    bash ./run-all-scanners.sh
    echo "SKANOWANIE ZAKOŃCZONE"
} 
export -f scan_now

yad --form --no-buttons --title "Aplikacja skanująca" --text "\n\n Ilość wykrytych skanerów: ${#detected_scanners[@]}. \n\n Wprowadź czas codziennego skanowania\n" --field=" Godziny" "" --field=" Minuty" "" --field="Rozpocznij codzienne skanowanie o nowej godzinie:BTN" 'bash -c "start_scanning_periodically %1 %2"'  --field="Skanuj teraz:BTN" 'bash -c "scan_now"' 

