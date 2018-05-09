---
title: posPay的http请求业务
tags: ipos
---
## 接入： `/posPay`

## pos机直接支付通知
- 接入： `posPayResultDirectNotify`
### 请求参数
```java
/**
 * 订单号
 */
private String orderNo;
/**
 * 终端号
 */
private String termNo;
/**
 * 主商户交易金额，单位分
 */
private long amount;
/**
 * 卡号
 */
private String cardNo;
/**
 * 检索号
 */
private String rrnNo;
/**
 * 发卡行
 */
private String cardType;
/**
 * 流水号
 */
private String traceNo;
/**
 * 交易日期
 */
private String transDate;
/**
 * 交易时间
 */
private String transTime;
/**
 * 订单备注
 */
private String remark;
/**
 * 交易结果
 */
private String payCode;
/**
 * 交易结果说明
 */
private String payMsg;
/**
 * 分账信息,josnList
 */
private String splitJson;
/**
 * 分账信息,dubbo调用使用
 */
private List<PosSplitOrderVO> splitOrderList;
```
### 泳道图

## 对账后长款处理
- 接入： `directNotifyForCheckLong`
### 请求参数
```java
/**
 * 订单号
 */
private String orderNo;
/**
 * 终端号
 */
private String termNo;
/**
 * 主商户交易金额，单位分
 */
private long amount;
/**
 * 卡号
 */
private String cardNo;
/**
 * 检索号
 */
private String rrnNo;
/**
 * 发卡行
 */
private String cardType;
/**
 * 流水号
 */
private String traceNo;
/**
 * 交易日期
 */
private String transDate;
/**
 * 交易时间
 */
private String transTime;
/**
 * 订单备注
 */
private String remark;
/**
 * 交易结果
 */
private String payCode;
/**
 * 交易结果说明
 */
private String payMsg;
/**
 * 分账信息,josnList
 */
private String splitJson;
/**
 * 分账信息,dubbo调用使用
 */
private List<PosSplitOrderVO> splitOrderList;
```
### 泳道图


