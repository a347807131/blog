---
title: IPos工程Dubbo接口
tags: ipos
---

## 退款Api

### prefund 退款预下单

#### 请求参数
```java
/**
 * 终端号
 */
private String termNo;

/**
 * 退款金额
 */
private Long amount;

/**
 * 交易检索号
 */
private String rrnNo;

/**
 * 退款备注
 */
private String rfdRemark;
```
#### 流程图

### 退款结果通知

#### 入参
```java
/**
 * 终端号
 */
private String termNo;
/**
 * 交易金额,单位分
 */
private Long amount;
/**
 * 订单号
 */
private String rfdOrderNo;
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
 * 交易日期，如20170724
 */
private String transDate;
/**
 * 交易时间，如145600
 */
private String transTime;
/**
 * 刷卡结果，00-成功
 */
private String payCode;
/**
 * 刷卡结果说明
 */
private String payMsg;
```
#### 流程图
