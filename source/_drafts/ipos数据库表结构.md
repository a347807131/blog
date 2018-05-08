##财务外发表account

||||
|---:|---:|---:|
|	|id     |bigint unsigned auto_increment                                                  |
|	jrn_no  |varchar(32) default '' not null comment        |'外发账务流水号',                           |
|	ac_dt   |varchar(8) default '' not null comment         |'会计日期',                              |
|	tx_dt   |varchar(8) default '' not null comment         |'外发交易日期',                            |
|	tx_tm   |varchar(6) default '' not null comment         |'外发交易时间',                            |
|	req_id  |varchar(32) default '' not null comment        |'请求id',                              |
|	bus_cnl |    varchar(3) default '' not null comment     |    '业务渠道',                          |
|	prd_no  |varchar(2) default '' not null comment         |'产品码',                               |
|	tx_typ  |varchar(2) default '' not null comment         |'交易类型',                              |
|	bus_typ |    varchar(4) default '' not null comment     |    '业务类型',                          |
|	org_cd  | varchar(6) default '' not null comment        |'机构编码',                              |
|	ccy     |varchar(3) default '' not null comment         |'币种',                                |
|	tx_amt  |decimal(18,2) default '0.00' not null comment  |'交易金额',                          |
|	ord_no  |varchar(32) default '' not null comment        |'订单号',                               |
|	ord_typ |varchar(2) default '' not null comment         |'订单类型',                              |
|	rvs_tx_typ |varchar(1) default 'N' not null comment     |    '冲正类型  N-正常 P-冲正处理中 C-冲正',       |
|	rvs_jrn    | varchar(32) default '' not null comment    |    '冲正流水号',                         |
|	post_dt    | varchar(8) default '' not null comment     |    '账务日期',                          |
|	post_tm    | varchar(6) default '' not null comment     |    '账务时间',                          |
|	post_ac_dt |  varchar(8) default '' not null comment    |    '账务会计日',                         |
|	post_jrn_no|     varchar(32) default '' not null comment|    '账务系统流水号',                   |
|	tx_sts |  varchar(2) default '' not null comment        |'交易状态 U-初始化 S-成功 F-失败',              |
|	chk_flg|     varchar(1) default '' not null comment     |    '对账标志',                          |
|	chk_sts|  varchar(1) default '' not null comment        |'对账状态',                              |
|	chk_dt | varchar(8) default '' not null comment         |'对账日期',                              |
|	chk_tm |  varchar(6) default '' not null comment        |'对账时间',                              |
|	rmk    | varchar(50) default '' not null comment        |'备注',                                |
|	tm_smp |  varchar(26) default '' not null comment       |'时间戳',                               |
|	msg_cd |  varchar(9) default '' not null comment        |'错误码',                               |
|	ae_num |  decimal(6) default '0' not null comment       |'分录笔数',                              |
|	msg_inf| varchar(128) default '' not null comment       |'账务系统错误信息',                          |
|	try_times|   int(2) default '0' not null comment        |'尝试次数',                              |
|	create_at|    timestamp default CURRENT_TIMESTAMP not null comment | '创建时间',              |

## 财务外发明细表
||||     
|---:|---:|---:|
|id     |bigint unsigned auto_increment
|jrn_no |varchar(32) default '' not null comment   | '外发账务流水号',     |
|ac_dt  | varchar(8) default '' not null comment   | '会计日期',        |
|cap_typ| varchar(6) default '' not null comment   | '资金种类',        |
|ccy    |varchar(3) default '' not null comment    | '币种',          |
|ac_typ |varchar(3) default '' not null comment    | '账户种类',        |
|ae_seq |varchar(6) default '' not null comment    | '分录序号',        |
|sep_cd |varchar(32) default '' not null comment   | '特征码',         |
|debit_amt  | decimal(18,2) default '0.00' not null comment| '借方金额',|
|credit_amt |decimal(18,2) default '0.00' not null comment | '贷方金额',|
|usr_no     | varchar(20) default '' not null comment      | '用户号', |
|tx_desc    | varchar(256) default '' not null comment     | '记账描述',|
|dc_flg     |varchar(1) default '' not null comment        | '借贷标识',|
|tm_smp     |varchar(26) default '' not null comment       | '时间戳', |

## 工行订单表-用于对账icbv_order

||||     
|---:|---:|---:|  
|id     |bigint unsigned auto_increment               |                         |
|check_bat_no |varchar(40) default '' null comment      |'对账批次号',             |
|tx_amt     |int unsigned default '0' not null comment  |'金额，单位分',            |
|tx_type    |varchar(1) default '' not null comment     |'类型：P-支付; R-退款',     |
|pos_card_no| varchar(20) default '' not null comment   |'卡号',                |
|pos_card_bank| varchar(20) default '' not null comment |'发卡行',               |
|pos_rrn_no  |   varchar(20) not null comment           |'交易POS检索号',          |
|pos_term_no |   varchar(20) not null comment           |'POS终端号',            |
|pos_trace_no|    varchar(20) default '' not null       | '交易POS流水号',         |
|order_date  |   varchar(8) default '' not null comment |'交易日期',              |
|order_time  |   varchar(8) default '' not null comment |'交易时间',              |
|check_rst   |varchar(255) default '' null comment      | '对账结果:S-成功 F-失败',   |
|create_at   |timestamp default CURRENT_TIMESTAMP not null, |更新时间戳|


## pos机表 pos_machine
||||             
|---:|---:|---:| 
|id        | int(11) unsigned auto_increment  |                         |
|merc_id   | varchar(20) default '0' not null comment |'商户号',          |
|merc_name |varchar(200) default '' not null comment  |  '商户名称',       |
|term_no   |  varchar(50) default '' not null comment |'终端号',          |
|version   |  varchar(50) default '' not null comment |'POS机型号',       |
|bank      | varchar(30) default '' not null comment  |  '归属机构名称',     |
|location  | varchar(100) default '' not null comment |'使用位置',         |
|active    | tinyint(2) default '1' not null comment  |  '1-激活',       |
|create_at |timestamp default CURRENT_TIMESTAMP not null,|             |
|create    | table pos_order   
  
  
## pos机订单 pos_order
||||             
|---:|---:|---:| 
|id      |bigint unsigned auto_increment    ||
|merc_id |varchar(20) not null comment         |     '商户号',                       |
|merc_usr_no| varchar(20) default '0' not nu   |  '商户用户号',                        |
|bus_type   |varchar(6) not null comment       | '业务类型',                          |
|order_no   |varchar(40) default '' not null comment |'订单号',                      |
|tx_amt     |decimal(18,2) unsigned default '0.00' |'金额，单位元',                     |
|tx_fee     |decimal(18,2) unsigned default '0.00' |'手续费，单位元',                    |
|split_amt  |decimal(18,2) unsigned default '0.00' |'分账金额',                       |
|pos_card_no| varchar(20) default '' not null comment   | '卡号',                   |
|pos_card_bank |varchar(20) default '' not null comment |'发卡行',                   |
|pos_rrn_no    | varchar(20) not null comment |'交易POS检索号',                        |
|pos_term_no |varchar(20) not null comment    |  'POS终端号',                        |
|pos_trace_no| varchar(20) default '' not null comment |'交易POS流水号',               |
|order_date |varchar(8) default '' not null comment    | '交易日期',                  |
|order_time |varchar(8) default '' not null comment    | '交易时间',                  |
|order_status| varchar(2) default 'U' not null comment |'订单状态',                   |
|rfd_amt| decimal(18,2) not null comment            |'已退款金额',                     |
|remark |varchar(255) default '' not null comment |'订单备注',                        |
|check_rst |inyint(2) default '0' not null comment| '对账结果:1-成功 2-短款 3-长款 4-金额错误', |
|create_at |imestamp default CURRENT_TIMESTAMP not null,    ||

## pos机退款单 pos_refund_order
||||             
|---:|---:|---:| 
|rfd_order_no|     bigint unsigned auto_increment comment| '退款订单号'                           |
|merc_id     |varchar(20) not null comment               |'商户号',                             |
|merc_usr_no |varchar(20) default '' not null comment    |'商户用户号',                           |
|bus_type    |varchar(6) not null comment                |'业务类型',                            |
|order_no    | varchar(40) default '' not null comment| '原订单号',                              |
|rfd_amt     |decimal(18,2) unsigned default '0.00'   |'金额，单位元',                             |
|rfd_fee     |decimal(18,2) unsigned default '0.00'   |'退手续费，金额元',                           |
|rfd_date    |varchar(8) default '' not null comment  |   'POS退款日期',                         |
|rfd_time    |varchar(8) default '' not null comment  |   'POS退款时间',                         |
|rfd_status  |varchar(2) default 'U' not null comment |'退款状态:U-初始化; P-进行中; S-成功; F-失败',      |
|hold_no     |varchar(40) default '' not null comment |'余额冻结编号',                             |
|hold_ac_type |varchar(5) default '' not null comment |'冻结账户类型',                             |
|unhold_status| varchar(2) default '' not null comment| '解冻状态：S-成功',                         |
|rsp_msg | varchar(255) default '' not null comment  | '响应消息',                               |
|remark  |varchar(255) default '' not null comment   |'退款备注',                                |
|create_at |timestamp default CURRENT_TIMESTAMP not null


## pos机子订单表pos_sub_order
||||             
|---:|---:|---:| 
|id      |bigint unsigned auto_increment                       |
|merc_id |varchar(20) not null comment|   '商户号',               |
|merc_usr_no| varchar(20) default '0' |'商户用户号',                |
|order_no   | varchar(40) default ''  |'订单号',                  |
|p_order_no |varchar(40) default ''   |父订单号',                  |
|tx_amt  |decimal(18,2) unsigned default '0.00' |'金额，单位元',     |
|tx_fee  |decimal(18,2) unsigned default '0.00' |'手续费，单位元',    |
|remark  |varchar(255) default '' not null comment |'订单备注',    |
|create_at| timestamp default CURRENT_TIMESTAMP not null,|     |
