#!/usr/bin/env bash

today=`date +%Y-%m-%d`
path=
trace=
day=0
environment=xy

while getopts "p:d:t:e:" opt; do
  case $opt in
    p)
      if [ $OPTARG ]; then
        path=$OPTARG
      fi
      ;;
    t)
      if [ $OPTARG ]; then
        trace=$OPTARG
      fi
      ;;
    d)
      if [ $OPTARG ]; then
        day=$OPTARG
      fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

if [[ -z "path" ]]; then
  exit 1
  echo "必须指定一个查询的path (-p -t 参数不能为空)"
fi
if [[ -z "$traceid" ]]; then
  echo "必须指定一个查询的trace (-p -t 参数不能为空)"
  exit 1
fi

echo search path:[$path] traceid:[$trace] search day:[$day]

if [[ $day -eq 0 ]]; then
  day=$today
else
  day=`date -d "$day days ago" '+%Y-%m-%d'`
fi


