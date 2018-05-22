---
title: shop日志查询
tags:
---

## 脚本

用法：sh ${sh} -p ${path} -t ${trace} [-d ${day}]
说明：脚本与列表文件需要放到一个目录下
- ${sh}为脚本名
- ${path}为工程名
- ${trace}为检索关键字
- -d 为选填参数默认为0，标识距今天多少天

### 执行脚本
```bash
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
if [[ -z "$trace" ]]; then
  echo "必须指定一个查询的trace (-p -t 参数不能为空)"
  exit 1
fi

if [[ $day -eq 0 ]]; then
  day=$today
else
  day=`date -d "$day days ago" '+%Y-%m-%d'`
fi

echo search path:[$path] traceid:[$trace] search day:[$day]

for i in `cat server.list`
do
  echo $i
  ssh -i ${LOGKEY} readonly@$i  "grep --color '$trace' /data/logs/${path}/root.$day*"
done

```
### 服务器列表文件 server.list

已包含的服务器工程
- paytool
- paycap
- shop
- scancode
- paygateway
- wallstreet
- irouter
- paysms
```bash
100.118.2.208
100.118.2.209
100.118.2.206
100.118.2.207
100.118.2.177
100.118.2.178
100.118.2.233
100.118.2.234
100.118.3.71
100.118.3.72
100.118.2.202
100.118.2.203
100.118.2.191
100.118.2.192
100.118.2.193
100.118.2.194
100.114.5.135
100.114.5.136
100.114.1.146
100.114.1.147
100.118.2.152
100.118.2.153
100.114.1.213
100.114.1.211
100.109.15.24
100.114.1.58
100.114.1.59
100.109.80.48
100.109.80.49
100.114.1.44
100.114.1.45
100.118.2.177
100.118.2.178
100.118.2.233
100.118.2.234
100.114.1.235
100.114.1.236
100.114.5.52
100.114.5.53
100.118.2.204
100.118.2.205
100.118.2.210
100.118.2.211
100.118.2.212
100.118.2.213
100.114.5.3
100.114.5.4
100.114.5.10
100.114.5.11
100.114.5.12
100.114.5.13
100.114.1.44
100.114.1.45
100.109.80.48
100.109.80.49
100.118.3.42
100.118.3.43
100.118.3.44
100.118.3.45
100.118.3.46
100.118.3.47
100.118.3.48
100.114.5.101
100.114.5.102
100.114.5.103
100.114.5.104
100.114.5.105
100.114.5.106
100.114.5.107
100.114.1.171
100.114.1.172
100.118.2.71
100.118.2.72
100.118.2.54
100.118.2.55
100.114.1.141
100.114.1.142
100.118.3.98
100.118.3.97
100.114.5.160
100.114.5.161
100.118.3.99
100.118.3.100
100.114.5.162
100.114.5.163
100.118.3.115
100.118.3.116
100.114.5.179
100.114.5.178
100.109.20.170
100.105.30.148
100.105.30.149
100.109.100.148
100.109.100.149
100.109.86.21
100.118.2.226
100.114.5.46
100.114.5.47
100.118.2.227
```

## 一键脚本

使用： sh ${sh} -t|-p [-d] 
```bash
#!/usr/bin/env bash

n:    query ptl log
# Usage:       sh findptllog -taaa -d1 -exy
# Author:      woodle
############################rm ###################################

today=`date +%Y-%m-%d`
param=
traceid=
day=0
environment=xy

paygatewayxy=(100.118.2.177 100.118.2.178 100.118.2.233 100.118.2.234 100.118.3.71 100.118.3.72)
paygatewayyz=(100.114.1.200 100.114.1.236 100.114.5.52 100.114.5.53 100.114.5.135 100.114.5.136)
paytoolxy=(100.118.2.204 100.118.2.205 100.118.2.210 100.118.2.211 100.118.2.212 100.118.2.213)
paytoolyz=(100.114.5.3 100.114.5.4 100.114.5.10 100.114.5.11 100.114.5.12 100.114.5.13)
wallstreetxy=(100.118.2.202 100.118.2.203 100.118.2.191 100.118.2.192 100.118.2.193 100.118.2.194)
wallstreetyz=(100.114.1.239 100.114.1.240 100.114.1.241 100.114.1.242 100.114.1.252 100.114.1.253)
irouterxy=(100.118.2.206 100.118.2.207)
irouteryz=(100.114.5.5 100.114.5.6)
paysmsxy=(100.118.2.208 100.118.2.209)
paysmsyz=(100.114.5.7 100.114.5.8)

paycap=(100.118.3.98 100.118.3.97 100.114.5.160 100.114.5.161 100.118.3.99 100.118.3.100 100.114.5.162 100.114.5.163 100.118.3.115 100.118.3.116 100.114.5.179 100.114.5.178)
#第一个为灰度服务器
shop=(100.109.20.170 100.105.30.148 100.105.30.149 100.109.100.148 100.109.100.149)
ipos=(100.109.86.21 100.118.2.226 100.114.5.46 100.114.5.47 100.118.2.227)
scancode=(100.114.1.213 100.114.1.214 100.118.2.152 100.118.2.153)

allxy=(${paygatewayxy[@]} ${wallstreetxy[@]} ${irouterxy[@]} ${paysmsxy[@]})
allyz=(${paygatewayyz[@]} ${wallstreetyz[@]} ${irouteryz[@]} ${paysmsyz[@]})

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

echo search key:[$param] traceid:[$traceivimd] search day:[$day] search environment:[$environment]

paygateway=${paygatewayyz[@]}
#paytool=${paytoolyz[@]}
wallstreet=${wallstreetyz[@]}
irouter=${irouteryz[@]}
paysms=${paysmsyz[@]}
if [ "$environment"x = "xy"x ]; then
  paygateway=${paygatewayxy[@]}
  #paytool=${paytoolxy[@]}
  wallstreet=${wallstreetxy[@]}
  irouter=${irouterxy[@]}
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
  for lineb in ${paysms[@]};
  do
    ipb=${lineb}
    echo "paysms $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/paysms/paysms.log.$day*"
    echo
  done
  for lineb in ${wallstreet[@]};
  do
    ipb=${lineb}
    echo "wallstreet $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/wallstreet/root.log.$day*"
    echo
  done
  for lineb in ${irouter[@]};
  do
    ipb=${lineb}
    echo "irouter $environment server: $ipb"
    echo "==========================================="
    ssh -i /home/user/caoss/key/readonly-zhifu readonly@$ipb "grep --color '$traceid' /data/logs/i-router/i-router.log.$day*"
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

```