#/bin/bash

#if optional range parameters were set
if [ $# -eq 2 ];then
  tmin=$1
  tmax=$2
  range=1
  echo "Range set to $tmin $tmax"
fi

cd processor0
time_list=`ls | grep -v constant`
cd - > /dev/null


echo $time_list

for t in $time_list; do
  #echo "gt max " `echo "$t > $tmax" | bc`
  #echo "lt min " `echo "$t < $tmin" | bc`
  if [ -d $t ]; then
    #echo "$t already done"
    continue
  elif [ $range ] && [ `echo "$t > $tmax" | bc` -eq 1 ]; then
    #echo "$t > $tmax"
    continue
  elif [ $range ] && [ `echo "$t < $tmin" | bc` -eq 1 ]; then
    #echo "$t < $tmin"
    continue
  else
    echo "reconstructing parts for time $t"

    reconstructPar -time $t
    if [ $? -ne 0 ]; then
      echo "ERROR reconstructing time $t, STOPPING"
    fi
  fi
done

