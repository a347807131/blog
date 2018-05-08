---
title: shop对外接口
date: 2018-05-08 15:00:11
tags:
---


## Web接口

### 商户账户服务

接口: `/api/merchant/account`
 - `get-detail` 获取商户信息详情
 - `detail` 获取商户信息详情(内部使用)
---

### 代付业务

接口: `/shopapi/agent-pay`
- 银行卡代扣 `pay-from-card`
- 单笔代付到银行卡 `pay-to-card`
- 批量代付到银行卡(excel上传) `batch-to-card`
- 批量代付到支付账户-中环接口调用 `batch-to-acc`
- 购买理财-第三方可做公司操作 `pay-for-licai`
- 理财还款到内部户-九信操作 `licai-repay`
- 理财还款到门店和第三方公司-第三方公司操作 `licai-reback`
- 理财后借钱周转-第三方公司操作 `licai-store-lend`
- 借钱周转回款-第三方公司操作 `licai-lend-back`
- 基金-申购 `fund-apply`
- 基金-批量赎回 `bat-fund-back`
- 基金-单笔赎回 `fund-back`
---

### 优惠相关业务(FavorController)

接口： `api/merchant/favor`
- `get-recommend`  获取推荐优惠
- `list`           获取卡卷列表
- `off-amount`     获取优惠金额
- `check-amount`   检查优惠金额
---

### 交易明细业务(FlowingController)

接口： `/api/merchant/flowing`
- `list` 明细列表查询
---

### 支付网关请求相关(GatewayController)

接口： `/api/merchant/gateway`
- `pay-callback` 支付回调
---

### 内部接口

接口： `/shopapi/inner`
- `fill-order-fee` 补充成功订单的手续费金额 
- `daily-balance-bill` 每天汇总所有商户金额
- `check-merc-fee` 检查商户的手续费核销
- `sync-tiaozhang-record` 查询并同步商户的部分收支记录，包括调帐记录
---

### 商户相关服务(merchantController)

接口： `/shopapi/merchant`
- `store-search` 查询门店列表
- `query-bal-list`  通过父商户查询子商户余额
---

### 订单服务业务

接口： `/api/merchant/order`
- `h5-generate` 扫码-H5页面预下单
- `native-generate` 扫码-端预下单
- `third-generate` 第三方应用(商户app等)预下单
- `get-detail` `detail` 获取订单详情
- `get-list` 获取订单列表
---

### pos临时服务业务(posController)

接口： `/shopapi/pos`
- `tcp-agent` 
- `shop/query 门店查询接口`
- `split-merc-query` 分账商户查询接口
- `pay-notify` 智能pos通知
- `py-check-long` 只能pos长款补单
- `refund` 智能pos退款
- `refund-notify` 智能pos退款通知 
---

### 用户扫码业务(QrcodeController)

接口： `/merchant/qrcode`
- `scan` 用户扫码
- `native-scan` 端扫借贷宝商户码
---

### 二维码订单业务

接口：`/shopapi`
- `qrcode/generate-common-byorder` 生成聚合订单二维码
- `inner/paytool-pay-notify` paytool订单通知
- `qrcode/common-qrcode-cnfig`聚合二维码配置信息
---                