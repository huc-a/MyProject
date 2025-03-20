-- 用户表
drop table if exists user;
create table user
(
    phone           varchar(20) not null primary key comment '手机号',
    username        varchar(20) not null comment '用户名',
    password        varchar(20) not null comment '密码',
    real_name       varchar(20) not null comment '真实姓名',
    sex             varchar(1)  not null comment '性别',
    birthday        date        not null comment '生日',
    address         varchar(50) not null comment '收货地址',
    create_datetime datetime    not null comment '创建时间',
    update_datetime datetime null comment '更新时间'
) comment '用户表';

INSERT INTO user(`phone`, `username`, `password`, `real_name`, `sex`, `birthday`, `address`, `create_datetime`, `update_datetime`) VALUES ('13333333333', 'lisi', '1234', '李四', '男', '2024-11-02', '中国', '2024-11-12 00:00:00', '2024-11-12 00:00:00');
INSERT INTO user(`phone`, `username`, `password`, `real_name`, `sex`, `birthday`, `address`, `create_datetime`, `update_datetime`) VALUES ('18888888888', 'zhangsan', '123', '张三', '女', '2024-11-01', '中国', '2024-11-12 00:00:00', '2024-11-13 00:00:00');


-- 管理员用户表
drop table if exists admin_user;
create table admin_user
(
    username        varchar(20) not null primary key comment '用户名',
    password        varchar(20) not null comment '密码',
    real_name       varchar(20) not null comment '真实姓名',
    sex             varchar(1)  not null comment '性别',
    birthday        date        not null comment '生日',
    create_datetime datetime    not null comment '创建日期',
    update_datetime datetime null comment '更新时间'
) comment '管理员用户表';

INSERT INTO admin_user(`username`, `password`, `real_name`, `sex`, `birthday`, `create_datetime`, `update_datetime`) VALUES ('admin', 'admin', '超级管理员', '男', '2024-11-10', '2024-11-10 15:23:17', '2024-11-10 15:23:35');


-- 商品表
drop table if exists goods;
create table goods
(
    id              varchar(50)    not null primary key comment '主键id',
    name            varchar(20)    not null comment '名称',
    brand           varchar(20)    not null comment '品牌',
    price           decimal(20, 2) not null comment '价格',
    stock           int            not null default 0 comment '库存',
    file_name       varchar(100) null comment '图片',
    remark          varchar(255) null comment '简介',
    is_delete       char(1)        not null default '0' comment '是否删除',
    create_datetime datetime       not null comment '创建时间',
    update_datetime datetime null comment '更新时间'
) comment '商品表';

-- 订单表
drop table if exists `order`;
create table `order`
(
    id                varchar(50)    not null primary key comment '主键id',
    user_phone        varchar(20)    not null comment '用户名',
    total_price       decimal(20, 2) not null comment '总价格',
    issue_datetime    datetime null comment '发货时间',
    received_datetime datetime null comment '签收时间',
    create_datetime   datetime       not null comment '创建日期',
    update_datetime   datetime null comment '更新时间'
) comment '订单表';


-- 订单详情表
drop table if exists order_details;
create table order_details
(
    order_id  varchar(50) null comment '订单id',
    goods_id  varchar(50)    not null comment '商品id',
    count     int            not null comment '数量',
    sub_total decimal(20, 2) not null comment '小计'
) comment '订单详情表';




-- 购物车表
drop table if exists shop_car;
create table shop_car
(
    id              int            not null AUTO_INCREMENT primary key comment 'id',
    goods_id        varchar(50)    not null comment '商品id',
    count           int            not null comment '数量',
    create_user     varchar(20)    not null comment '创建人',
    create_datetime datetime       not null comment '创建日期'
) comment '购物车表';