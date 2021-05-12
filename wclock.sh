
#!/bin/bash
function print_times(){
divider=================================
divider=$divider$divider$divider$divider$divider

header="\n %-32s %-32s %-32s\n"
format=" %-31s %31s %31s\n"

width=83

printf "$header" "California" "India" "Spain/Italy"

printf "%$width.${width}s\n" "$divider"

printf "$format" "$(TZ=America/Los_Angeles date -d "$TIMEARG $LTIME")" "$(TZ=Asia/Colombo date -d "$TIMEARG $LTIME")" "$(TZ=Europe/Madrid date -d "$TIMEARG $LTIME")"
}

while read -r line; do
    if [[ $line == "Local time:"* ]]; then
      LTIME=$(echo $line | awk '{print $6}')
      NOW=$(echo $line | awk '{print $5}')
    elif [[ $line == "Time zone:"* ]]; then
      TIMEZ=$(echo $line | awk '{print $3}')
    fi
done < <(timedatectl)

if [ -z $1 ]; then
TIMEARG=$NOW
else
TIMEARG=$1
fi

print_times
