---
title: pos简易业务
tags:
---
## 接入： `/shopapi/pos`
说明：临时方案，以后会使用智能pos方案

## tcp代付
- 接入： `tcp/agent`
### 请求参数
```java
private String jsonData;        //请求数据

private String ts;              //请求时的时间

private String appkey;          //应用标识
```
### 泳道图

## 门店查询接口
- 接入： `shop/query`
### 请求参数
```java
private String termNo;

private Long amount;

private String busNo;
```
### 泳道图

## 分账商户查询接口
- 接入： `split-merc-query`
### 请求参数
```java
	private String termNo;
	
	private Long amount;
	
	private String busNo;
```
### 泳道图

## 智能pos通知
- 接入： `pay-notify`
### 请求参数
```java
private String merchantId;  // 商户号

private String termNo;      // pos机终端号

private Long amount = 0l;   // 单位分

private long mercAccount;   // 商户本地库的ID

private String cardNo = ""; // 卡号

private String busNo;       // 业务编号

private String rrnNo;       // 检索号

private String cardType;    // 发卡行

private String traceNo;     // 流水号

private String transDate = "";   // 交易日期

private String transTime = "";   // 交易时间

private String remark = ""; // 订单备注

private String rspCode = "00";    // 刷卡结果 00-成 功

private String rspMsg = "";      // 刷卡说明

private String splitAccount = "";

private String splitAmount = "";
```
### 泳道图

## 智能pos长款补单
- 接入： `pay-check-long`
### 请求参数
```java
private String merchantId;  // 商户号

private String termNo;      // pos机终端号

private long mercAccount;   // 商户本地库的ID

private String busNo;       // 业务编号

private String rrnNo;       // 检索号

private String cardType;    // 发卡行

private String traceNo;     // 流水号

private String remark = ""; // 订单备注

private String splitAccount;

private String splitAmount;
```
### 泳道图

## 智能pos退款
- 接入： `refund`
### 请求参数
### 泳道图

## 智能pos退款
- 接入： `refund-notify`
### 请求参数
### 泳道图






