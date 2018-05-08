---
title: ipos对外接口
date: 2018-05-08 15:03:24
tags:
---


## web接口

### http补偿业务(AccountCompensateController)

接口： `/accountCompentsate`
- `test`

### 通用Coontroller

接口： `common`
- `checkServer`
- `checkIcbc` 对账(临时)

### 订单控制业务(OrderController)

接口： `order`
- `orderCompensate` 订单补偿
- `clearCheck`

### pos机http接口

接口： `/posMachine`
- `queryPos`

### posPay的http请求

接口： `/posPay`
- `posPayResultDirectNotify` pos机直接支付通知
- `directNotifyForCheckLong` 对账后长款处理