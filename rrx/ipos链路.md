# ipos链路

## pos收单

pos交易链条：pos机->paygateway->shopjava->ipos→清结算系统->账务

### 具体日志

- 10:21:29.809 ipos 支付结果通知
> [2018-05-22] [10:21:29.809] [INFO] [traceid:1526955689802] [utils.LogUtil] [url:/ipos/posPay/posPayResultDirectNotify, param: {"amount":"721000","cardNo":"622827******6964872","cardType":"中国农业银行 /借","merchantId":"800001400010010","orderNo":"1112018052230006331","payCode":"00","payMsg":"交易成功","remark":"京东嘉苑","requestId":"1526955689802","rrnNo":"30006331","sign":"418a20d43968493766d471b73743b561","splitJson":"","termNo":"150248010119012","traceNo":"050473","transDate":"20180522","transTime":"102106"}]

- 10:21:29.892 paygateway  调shop服务
> {"timestamp":"2018-05-22 [10:21:29.892]","level":"INFO","logger":"util.RequestUtil","traceid":"01c05afe3981419995c84a354536c507","logtype":"0","merchantid":"800001400010001","logmsg":"调用shop服务返回的结果为{\"data\":{\"orderNo\":\"1112018052230006331\"},\"errmsg\":\"成
功\",\"errno\":\"C0000\"}","localip":"100.114.5.52","appid":"paygateway","version":"1.0"}
