#!/usr/bin/env bash

n:    query ptl log
# Usage:       sh findptllog -taaa -d1 -exy
# Author:      woodle
###############################################################

today=`date +%Y-%m-%d`
param=
traceid=
day=0
environment=xy


all=(${allxy[@]} ${allyz[@]} ${paycap[@]} ${ipos[@]} ${shop[@]} ${scancode[@]})

while getopts "p:d:t:e:" opt; do
  case $opt in
    p)
      if [ $OPTARG ]; then
        param=$OPTARG
      fi
      ;;
    t)
      if [ $OPTARG ]; then
        traceid=$OPTARG
      fi
      ;;
    d)
      if [ $OPTARG ]; then
        day=$OPTARG
      fi
      ;;
    e)
      if [ $OPTARG ]; then
        environment=$OPTARG
      fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

if [[ -z "$param" ]]; then
  if [[ -z "$traceid" ]]; then
    echo "必须指定一个查询的key (-p -t 参数不能同时为空)"
    exit 1
  fi
fi

if [[ $day -eq 0 ]]; then
  day=$today
else
  day=`date -d "$day days ago" '+%Y-%m-%d'`
fi

echo search key:[$param] traceid:[$traceid] search day:[$day] search environment:[$environment]

paygateway=${paygatewayyz[@]}
#paytool=${paytoolyz[@]}
wallstreet=${wallstreetyz[@]}
irouter=${irouteryz[@]}
paysms=${paysmsyz[@]}
if [ "$environment"x = "xy"x ]; then
  paygateway=${paygatewayxy[@]}
  #paytool=${paytoolxy[@]}
  wallstreet=${wallstreetxy[@]}
  #irouter=${irouterxy[@]}
  paysms=${paysmsxy[@]}
fi

#根据traceid去所有机器查找日志
searchByTraceId() {
  traceid=$1
  #根据traceid，遍历搜索all里所有机器上的日志
  for lineb in ${paygateway[@]};
  do
    ipb=${lineb}
    echo "paygateway $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/paygateway/root.$day*"
    echo
  done
  for lineb in ${paycap[@]};
  do
    ipb=${lineb}
    echo "paycap $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/paycap/root.$day*"
    echo
  done
  for lineb in ${paycashier[@]};
  do
    ipb=${lineb}
    echo "paycashier $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/paycashier/root.$day*"
    echo
  done
  for lineb in ${shop[@]};
  do
    ipb=${lineb}
    echo "shop $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/shop/root.$day*"
    echo
  done
  for lineb in ${ipos[@]};
  do
    ipb=${lineb}
    echo "ipos $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/ipos/root.log.$day*"
    echo
  done
  for lineb in ${scancode[@]};
  do
    ipb=${lineb}
    echo "scancode $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/scancode/root.$day*"
    echo
  done
}

#如果traceid为空 从gateway机器的日志里找到入口的机器列表，找到traceid
if [[ -z "$traceid" ]]; then
  for line in ${paygateway[@]};
    do
      ip=${line}
      if [[ -z "$ip" ]]; then
        continue
      fi
      traceids=`ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ip "grep '$param' /data/logs/paygateway/root.$day* | grep -Eo  '\"traceid\":\"[0-9a-z]+\"'| uniq | tr -d '\"' | cut -d : -f 2"`
      #echo "$ip - $traceid"
      if [[ -n  "$traceids" ]]; then
        arr=(${traceids// / })
        for traceid in ${arr[@]}
        do
          echo "ip: $ip find trace id: $traceid"
          searchByTraceId $traceid
        done
      fi
  done
else
  #根据traceid，遍历搜索all里所有机器上的日志
  searchByTraceId $traceid
fi

if [[ -z "$traceid" ]]; then
  echo "未根据请求参数找到对应的traceid"
  exit 1
fi

