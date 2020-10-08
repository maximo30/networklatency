#!/bin/bash
#Health checks internet connection
address="www.google.com"
info="Process: "
info+=$$
info+=" Starting ping check on ${address}"
echo $info

#Only when the file is being created
echo "Status,Ping delay (ms),Year,Month,Day,Hour,Minute,Second,Full Date">> timeout.csv

while true;
do
  #ping -c1 $address | awk -F' |=' '$10=="time"'
  t="$(ping -c 1 8.8.8.8 | sed -ne '/.*time=/{;s///;s/\..*//;p;}')"
  if [ ! -n "$t" ]
    then
      echo "0,NaN",$(date '+%Y'),$(date '+%m'),$(date '+%d'),$(date '+%H'),$(date '+%M'),$(date '+%S'),$(date '+%Y/%m/%d %H:%M:%S')>> timeout.csv
    else
      echo "1,"$t,$(date '+%Y'),$(date '+%m'),$(date '+%d'),$(date '+%H'),$(date '+%M'),$(date '+%S'),$(date '+%Y/%m/%d %H:%M:%S')>> timeout.csv
  fi
  sleep 1
done