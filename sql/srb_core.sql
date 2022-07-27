/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3306
 Source Schema         : srb_core

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 27/07/2022 15:50:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for borrow_info
-- ----------------------------
DROP TABLE IF EXISTS `borrow_info`;
CREATE TABLE `borrow_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '借款用户id',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '借款金额',
  `period` int(0) NULL DEFAULT NULL COMMENT '借款期限',
  `borrow_year_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT '年化利率',
  `return_method` tinyint(0) NULL DEFAULT NULL COMMENT '还款方式 1-等额本息 2-等额本金 3-每月还息一次还本 4-一次还本',
  `money_use` tinyint(0) NULL DEFAULT NULL COMMENT '资金用途',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态（0：未提交，1：审核中， 2：审核通过， -1：审核不通过）',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借款信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow_info
-- ----------------------------
INSERT INTO `borrow_info` VALUES (7, 2, 100000.00, 1, 0.12, 1, 1, 2, '2022-07-25 11:12:25', '2022-07-25 11:12:25', 0);
INSERT INTO `borrow_info` VALUES (8, 4, 100000.00, 6, 0.12, 2, 2, 2, '2022-07-26 19:39:09', '2022-07-26 19:39:09', 0);

-- ----------------------------
-- Table structure for borrower
-- ----------------------------
DROP TABLE IF EXISTS `borrower`;
CREATE TABLE `borrower`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '用户id',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '身份证号',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `sex` tinyint(0) NULL DEFAULT NULL COMMENT '性别（1：男 0：女）',
  `age` tinyint(0) NULL DEFAULT NULL COMMENT '年龄',
  `education` tinyint(0) NULL DEFAULT NULL COMMENT '学历',
  `is_marry` tinyint(1) NULL DEFAULT NULL COMMENT '是否结婚（1：是 0：否）',
  `industry` tinyint(0) NULL DEFAULT NULL COMMENT '行业',
  `income` tinyint(0) NULL DEFAULT NULL COMMENT '月收入',
  `return_source` tinyint(0) NULL DEFAULT NULL COMMENT '还款来源',
  `contacts_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人名称',
  `contacts_mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人手机',
  `contacts_relation` tinyint(0) NULL DEFAULT NULL COMMENT '联系人关系',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态（0：未认证，1：认证中， 2：认证通过， -1：认证失败）',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借款人' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrower
-- ----------------------------
INSERT INTO `borrower` VALUES (4, 2, '小王', '0', '18482020182', 1, 30, 4, 0, 6, 4, 1, '小王', '13444444444', 3, 2, '2022-07-15 20:14:21', '2022-07-25 12:07:23', 0);
INSERT INTO `borrower` VALUES (5, 4, '小李', '510511111111111111', '18482020180', 1, 20, 4, 0, 3, 3, 2, '小李', '18482020180', 4, 2, '2022-07-26 18:50:46', '2022-07-26 18:50:46', 0);

-- ----------------------------
-- Table structure for borrower_attach
-- ----------------------------
DROP TABLE IF EXISTS `borrower_attach`;
CREATE TABLE `borrower_attach`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `borrower_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '借款人id',
  `image_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片类型（idCard1：身份证正面，idCard2：身份证反面，house：房产证，car：车）',
  `image_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片路径',
  `image_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_borrower_id`(`borrower_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借款人上传资源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrower_attach
-- ----------------------------
INSERT INTO `borrower_attach` VALUES (13, 4, 'idCard1', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/idCard1/2022/07/15/0c7956b1-e87a-407f-a22e-532510746a12.jpg', '正面1.jpg', '2022-07-15 20:14:22', '2022-07-15 20:14:22', 0);
INSERT INTO `borrower_attach` VALUES (14, 4, 'idCard2', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/idCard2/2022/07/15/c3d2fc1c-0364-46f5-b3e0-6af21ba8c72e.jpg', '反面.jpg', '2022-07-15 20:14:22', '2022-07-15 20:14:22', 0);
INSERT INTO `borrower_attach` VALUES (15, 4, 'house', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/house/2022/07/15/17048d94-fcb6-435f-a215-eb537438c25a.jpg', 'house.jpg', '2022-07-15 20:14:22', '2022-07-15 20:14:22', 0);
INSERT INTO `borrower_attach` VALUES (16, 4, 'car', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/car/2022/07/15/818a68f7-0cd7-43cc-b2f5-3463d49e0338.jpg', 'car.jpg', '2022-07-15 20:14:22', '2022-07-15 20:14:22', 0);
INSERT INTO `borrower_attach` VALUES (17, 5, 'idCard1', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/idCard1/2022/07/26/5ff79dc9-681e-43b3-910b-04e45d2ded67.jpg', '正面2.jpg', '2022-07-26 18:50:46', '2022-07-26 18:50:46', 0);
INSERT INTO `borrower_attach` VALUES (18, 5, 'idCard2', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/idCard2/2022/07/26/fe3c676b-d296-4ad5-a94a-e3a59d4f3180.jpg', '反面.jpg', '2022-07-26 18:50:46', '2022-07-26 18:50:46', 0);
INSERT INTO `borrower_attach` VALUES (19, 5, 'house', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/house/2022/07/26/1bcf4596-e885-4ad5-91b9-625b97d6e75f.jpg', 'house.jpg', '2022-07-26 18:50:46', '2022-07-26 18:50:46', 0);
INSERT INTO `borrower_attach` VALUES (20, 5, 'car', 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/car/2022/07/26/69edbfe7-25ad-4617-8463-c79204489a84.jpg', 'car.jpg', '2022-07-26 18:50:46', '2022-07-26 18:50:46', 0);

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parent_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '上级id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `value` int(0) NULL DEFAULT NULL COMMENT '值',
  `dict_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记（0:不可用 1:可用）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_parent_id_value`(`parent_id`, `value`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82008 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES (1, 0, '全部分类', NULL, 'ROOT', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (20000, 1, '行业', NULL, 'industry', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (20001, 20000, 'IT', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (20002, 20000, '医生', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (20003, 20000, '教师', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (20004, 20000, '导游', 4, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (20005, 20000, '律师', 5, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (20006, 20000, '其他', 6, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (30000, 1, '学历', NULL, 'education', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (30001, 30000, '高中', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (30002, 30000, '大专', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (30003, 30000, '本科', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (30004, 30000, '研究生', 4, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (30005, 30000, '其他', 5, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (40000, 1, '收入', NULL, 'income', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (40001, 40000, '0-3000', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (40002, 40000, '3000-5000', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (40003, 40000, '5000-10000', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (40004, 40000, '10000以上', 4, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (50000, 1, '收入来源', NULL, 'returnSource', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (50001, 50000, '工资', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (50002, 50000, '股票', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (50003, 50000, '兼职', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (60000, 1, '关系', NULL, 'relation', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (60001, 60000, '夫妻', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (60002, 60000, '兄妹', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (60003, 60000, '父母', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (60004, 60000, '其他', 4, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (70000, 1, '还款方式', NULL, 'returnMethod', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (70001, 70000, '等额本息', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (70002, 70000, '等额本金', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (70003, 70000, '每月还息一次还本', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (70004, 70000, '一次还本还息', 4, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (80000, 1, '资金用途', NULL, 'moneyUse', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (80001, 80000, '旅游', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (80002, 80000, '买房', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (80003, 80000, '装修', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (80004, 80000, '医疗', 4, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (80005, 80000, '美容', 5, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (80006, 80000, '其他', 6, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (81000, 1, '借款状态', NULL, 'borrowStatus', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (81001, 81000, '待审核', 0, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (81002, 81000, '审批通过', 1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (81003, 81000, '还款中', 2, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (81004, 81000, '结束', 3, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (81005, 81000, '审批不通过', -1, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82000, 1, '学校性质', NULL, 'SchoolStatus', '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82001, 82000, '211/985', NULL, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82002, 82000, '一本', NULL, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82003, 82000, '二本', NULL, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82004, 82000, '三本', NULL, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82005, 82000, '高职高专', NULL, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82006, 82000, '中职中专', NULL, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);
INSERT INTO `dict` VALUES (82007, 82000, '高中及以下', NULL, NULL, '2022-07-11 20:25:43', '2022-07-11 20:25:43', 0);

-- ----------------------------
-- Table structure for integral_grade
-- ----------------------------
DROP TABLE IF EXISTS `integral_grade`;
CREATE TABLE `integral_grade`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `integral_start` int(0) NULL DEFAULT NULL COMMENT '积分区间开始',
  `integral_end` int(0) NULL DEFAULT NULL COMMENT '积分区间结束',
  `borrow_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '借款额度',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分等级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of integral_grade
-- ----------------------------
INSERT INTO `integral_grade` VALUES (1, 10, 50, 10000.00, '2020-12-08 17:02:29', '2021-02-19 17:58:10', 0);
INSERT INTO `integral_grade` VALUES (2, 51, 100, 30000.00, '2020-12-08 17:02:42', '2022-07-11 13:20:50', 0);
INSERT INTO `integral_grade` VALUES (3, 101, 2000, 100000.00, '2020-12-08 17:02:57', '2022-07-11 13:20:51', 0);
INSERT INTO `integral_grade` VALUES (4, 2001, 3000, 1000000.00, '2022-07-10 17:16:15', '2022-07-11 13:20:54', 0);
INSERT INTO `integral_grade` VALUES (5, 1, 1, 1.00, '2022-07-11 14:13:40', '2022-07-11 14:13:50', 1);
INSERT INTO `integral_grade` VALUES (6, 1, 1, 1.00, '2022-07-11 14:15:27', '2022-07-11 14:15:34', 1);

-- ----------------------------
-- Table structure for lend
-- ----------------------------
DROP TABLE IF EXISTS `lend`;
CREATE TABLE `lend`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '借款用户id',
  `borrow_info_id` bigint(0) NULL DEFAULT NULL COMMENT '借款信息id',
  `lend_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标的编号',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '标的金额',
  `period` int(0) NULL DEFAULT NULL COMMENT '投资期数',
  `lend_year_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT '年化利率',
  `service_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT '平台服务费率',
  `return_method` tinyint(0) NULL DEFAULT NULL COMMENT '还款方式',
  `lowest_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '最低投资金额',
  `invest_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '已投金额',
  `invest_num` int(0) NULL DEFAULT NULL COMMENT '投资人数',
  `publish_date` datetime(0) NULL DEFAULT NULL COMMENT '发布日期',
  `lend_start_date` date NULL DEFAULT NULL COMMENT '开始日期',
  `lend_end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `lend_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '说明',
  `expect_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '平台预期收益',
  `real_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '实际收益',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态',
  `check_time` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `check_admin_id` bigint(0) NULL DEFAULT NULL COMMENT '审核用户id',
  `payment_time` datetime(0) NULL DEFAULT NULL COMMENT '放款时间',
  `payment_admin_id` datetime(0) NULL DEFAULT NULL COMMENT '放款人id',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_lend_no`(`lend_no`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_borrow_info_id`(`borrow_info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标的准备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend
-- ----------------------------
INSERT INTO `lend` VALUES (4, 2, 7, 'LEND20220725160233827', '白领贷', 100000.00, 1, 0.12, 0.05, 1, 100.00, 0.00, 0, '2022-07-25 16:02:34', '2022-07-26', '2022-08-26', '白领贷描述', 416.67, 0.00, 1, '2022-07-25 16:02:34', 1, NULL, NULL, '2022-07-25 16:02:33', '2022-07-25 16:02:33', 0);
INSERT INTO `lend` VALUES (5, 4, 8, 'LEND20220726194922849', '买房贷款', 100000.00, 6, 0.12, 0.05, 2, 100.00, 100000.00, 1, '2022-07-26 19:49:22', '2022-07-27', '2023-01-27', '买房贷款描述', 2500.00, 2500.00, 2, '2022-07-26 19:49:22', 1, '2022-07-27 10:37:58', NULL, '2022-07-26 19:49:22', '2022-07-26 19:49:22', 0);

-- ----------------------------
-- Table structure for lend_item
-- ----------------------------
DROP TABLE IF EXISTS `lend_item`;
CREATE TABLE `lend_item`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `lend_item_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '投资编号',
  `lend_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '标的id',
  `invest_user_id` bigint(0) NULL DEFAULT NULL COMMENT '投资用户id',
  `invest_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '投资人名称',
  `invest_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '投资金额',
  `lend_year_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT '年化利率',
  `invest_time` datetime(0) NULL DEFAULT NULL COMMENT '投资时间',
  `lend_start_date` date NULL DEFAULT NULL COMMENT '开始日期',
  `lend_end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `expect_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '预期收益',
  `real_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '实际收益',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态（0：默认 1：已支付 2：已还款）',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_lend_item_no`(`lend_item_no`) USING BTREE,
  INDEX `idx_lend_id`(`lend_id`) USING BTREE,
  INDEX `idx_invest_user_id`(`invest_user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标的出借记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend_item
-- ----------------------------
INSERT INTO `lend_item` VALUES (7, 'INVEST20220727103301107', 5, 3, '小红', 100000.00, 0.12, '2022-07-27 10:33:02', '2022-07-27', '2023-01-27', 3499.94, 0.00, 1, '2022-07-27 10:33:01', '2022-07-27 10:33:01', 0);

-- ----------------------------
-- Table structure for lend_item_return
-- ----------------------------
DROP TABLE IF EXISTS `lend_item_return`;
CREATE TABLE `lend_item_return`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `lend_return_id` bigint(0) NULL DEFAULT NULL COMMENT '标的还款id',
  `lend_item_id` bigint(0) NULL DEFAULT NULL COMMENT '标的项id',
  `lend_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '标的id',
  `invest_user_id` bigint(0) NULL DEFAULT NULL COMMENT '出借用户id',
  `invest_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '出借金额',
  `current_period` int(0) NULL DEFAULT NULL COMMENT '当前的期数',
  `lend_year_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT '年化利率',
  `return_method` tinyint(0) NULL DEFAULT NULL COMMENT '还款方式 1-等额本息 2-等额本金 3-每月还息一次还本 4-一次还本',
  `principal` decimal(10, 2) NULL DEFAULT NULL COMMENT '本金',
  `interest` decimal(10, 2) NULL DEFAULT NULL COMMENT '利息',
  `total` decimal(10, 2) NULL DEFAULT NULL COMMENT '本息',
  `fee` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '手续费',
  `return_date` date NULL DEFAULT NULL COMMENT '还款时指定的还款日期',
  `real_return_time` datetime(0) NULL DEFAULT NULL COMMENT '实际发生的还款时间',
  `is_overdue` tinyint(1) NULL DEFAULT NULL COMMENT '是否逾期',
  `overdue_total` decimal(10, 2) NULL DEFAULT NULL COMMENT '逾期金额',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态（0-未归还 1-已归还）',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_lend_return_id`(`lend_return_id`) USING BTREE,
  INDEX `idx_lend_item_id`(`lend_item_id`) USING BTREE,
  INDEX `idx_lend_id`(`lend_id`) USING BTREE,
  INDEX `idx_invest_user_id`(`invest_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标的出借回款记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend_item_return
-- ----------------------------
INSERT INTO `lend_item_return` VALUES (16, 10, 7, 5, 3, 100000.00, 1, 0.12, 2, 16666.67, 999.99, 17666.66, 0.00, '2022-08-27', NULL, 0, NULL, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_item_return` VALUES (17, 11, 7, 5, 3, 100000.00, 2, 0.12, 2, 16666.67, 833.32, 17499.99, 0.00, '2022-09-27', NULL, 0, NULL, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_item_return` VALUES (18, 12, 7, 5, 3, 100000.00, 3, 0.12, 2, 16666.67, 666.66, 17333.33, 0.00, '2022-10-27', NULL, 0, NULL, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_item_return` VALUES (19, 13, 7, 5, 3, 100000.00, 4, 0.12, 2, 16666.67, 499.99, 17166.66, 0.00, '2022-11-27', NULL, 0, NULL, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_item_return` VALUES (20, 14, 7, 5, 3, 100000.00, 5, 0.12, 2, 16666.67, 333.32, 16999.99, 0.00, '2022-12-27', NULL, 0, NULL, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_item_return` VALUES (21, 15, 7, 5, 3, 100000.00, 6, 0.12, 2, 16666.67, 166.66, 16833.33, 0.00, '2023-01-27', NULL, 0, NULL, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);

-- ----------------------------
-- Table structure for lend_return
-- ----------------------------
DROP TABLE IF EXISTS `lend_return`;
CREATE TABLE `lend_return`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `lend_id` bigint(0) NULL DEFAULT NULL COMMENT '标的id',
  `borrow_info_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '借款信息id',
  `return_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '还款批次号',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '借款人用户id',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '借款金额',
  `base_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '计息本金额',
  `current_period` int(0) NULL DEFAULT NULL COMMENT '当前的期数',
  `lend_year_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT '年化利率',
  `return_method` tinyint(0) NULL DEFAULT NULL COMMENT '还款方式 1-等额本息 2-等额本金 3-每月还息一次还本 4-一次还本',
  `principal` decimal(10, 2) NULL DEFAULT NULL COMMENT '本金',
  `interest` decimal(10, 2) NULL DEFAULT NULL COMMENT '利息',
  `total` decimal(10, 2) NULL DEFAULT NULL COMMENT '本息',
  `fee` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '手续费',
  `return_date` date NULL DEFAULT NULL COMMENT '还款时指定的还款日期',
  `real_return_time` datetime(0) NULL DEFAULT NULL COMMENT '实际发生的还款时间',
  `is_overdue` tinyint(1) NULL DEFAULT NULL COMMENT '是否逾期',
  `overdue_total` decimal(10, 2) NULL DEFAULT NULL COMMENT '逾期金额',
  `is_last` tinyint(1) NULL DEFAULT NULL COMMENT '是否最后一次还款',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态（0-未归还 1-已归还）',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_return_no`(`return_no`) USING BTREE,
  INDEX `idx_lend_id`(`lend_id`) USING BTREE,
  INDEX `idx_borrow_info_id`(`borrow_info_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '还款记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend_return
-- ----------------------------
INSERT INTO `lend_return` VALUES (10, 5, 8, 'RETURN20220727103758834', 4, 100000.00, 100000.00, 1, 0.12, 2, 16666.67, 999.99, 17666.66, 0.00, '2022-08-27', NULL, 0, NULL, 0, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_return` VALUES (11, 5, 8, 'RETURN20220727103758096', 4, 100000.00, 100000.00, 2, 0.12, 2, 16666.67, 833.32, 17499.99, 0.00, '2022-09-27', NULL, 0, NULL, 0, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_return` VALUES (12, 5, 8, 'RETURN20220727103758905', 4, 100000.00, 100000.00, 3, 0.12, 2, 16666.67, 666.66, 17333.33, 0.00, '2022-10-27', NULL, 0, NULL, 0, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_return` VALUES (13, 5, 8, 'RETURN20220727103758206', 4, 100000.00, 100000.00, 4, 0.12, 2, 16666.67, 499.99, 17166.66, 0.00, '2022-11-27', NULL, 0, NULL, 0, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_return` VALUES (14, 5, 8, 'RETURN20220727103758891', 4, 100000.00, 100000.00, 5, 0.12, 2, 16666.67, 333.32, 16999.99, 0.00, '2022-12-27', NULL, 0, NULL, 0, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);
INSERT INTO `lend_return` VALUES (15, 5, 8, 'RETURN20220727103758799', 4, 100000.00, 100000.00, 6, 0.12, 2, 16666.67, 166.66, 16833.33, 0.00, '2023-01-27', NULL, 0, NULL, 1, 0, '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);

-- ----------------------------
-- Table structure for trans_flow
-- ----------------------------
DROP TABLE IF EXISTS `trans_flow`;
CREATE TABLE `trans_flow`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '用户id',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `trans_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '交易单号',
  `trans_type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '交易类型（1：充值 2：提现 3：投标 4：投资回款 ...）',
  `trans_type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易类型名称',
  `trans_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '交易金额',
  `memo` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_trans_no`(`trans_no`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '交易流水表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trans_flow
-- ----------------------------
INSERT INTO `trans_flow` VALUES (57, 3, '小红', 'CHARGE20220726183543387', 1, '充值', 100000.00, '充值', '2022-07-26 18:35:48', '2022-07-26 18:35:48', 0);
INSERT INTO `trans_flow` VALUES (58, 3, '小红', 'INVEST20220727103301107', 2, '投标锁定', 100000.00, '项目编号:LEND20220726194922849,项目名称:买房贷款', '2022-07-27 10:33:09', '2022-07-27 10:33:09', 0);
INSERT INTO `trans_flow` VALUES (59, 4, '小李', 'LOAN20220727103758849', 5, '放款到账', 97500.00, '开始放款，项目编号:LEND20220726194922849,项目名称:买房贷款', '2022-07-27 10:37:58', '2022-07-27 10:37:58', 0);

-- ----------------------------
-- Table structure for user_account
-- ----------------------------
DROP TABLE IF EXISTS `user_account`;
CREATE TABLE `user_account`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '用户id',
  `amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '帐户可用余额',
  `freeze_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '冻结金额',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  `version` int(0) NOT NULL DEFAULT 0 COMMENT '版本号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户账户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_account
-- ----------------------------
INSERT INTO `user_account` VALUES (1, 1, 0.00, 0.00, '2022-07-13 14:55:43', '2022-07-13 14:55:43', 0, 0);
INSERT INTO `user_account` VALUES (2, 2, 0.00, 0.00, '2022-07-14 21:24:16', '2022-07-14 21:24:16', 0, 0);
INSERT INTO `user_account` VALUES (3, 3, 0.00, 0.00, '2022-07-26 18:29:35', '2022-07-27 10:37:58', 0, 0);
INSERT INTO `user_account` VALUES (4, 4, 97500.00, 0.00, '2022-07-26 18:36:57', '2022-07-27 10:37:58', 0, 0);

-- ----------------------------
-- Table structure for user_bind
-- ----------------------------
DROP TABLE IF EXISTS `user_bind`;
CREATE TABLE `user_bind`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '用户id',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户姓名',
  `id_card` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '身份证号',
  `bank_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `bank_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行类型',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `bind_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '绑定账户协议号',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户绑定表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_bind
-- ----------------------------
INSERT INTO `user_bind` VALUES (8, 2, '小王', '111222333444555', '251253712312321', '中国银行', '18482020182', '81f40b6f1bb341969bdce1827b317efb', 1, '2022-07-25 09:53:46', '2022-07-25 09:53:46', 0);
INSERT INTO `user_bind` VALUES (9, 3, '小红', '510522222222222222', '231233333333333333', '民生银行', '17683004240', 'ddd1066e996f45a5bf735d54deff86b5', 1, '2022-07-26 18:33:43', '2022-07-26 18:33:43', 0);
INSERT INTO `user_bind` VALUES (10, 4, '小李', '510511111111111111', '3413241111111111111', '民生银行', '18482020180', '08c679e45f924926a2b91c10afb8b192', 1, '2022-07-26 18:38:00', '2022-07-26 18:38:00', 0);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '1：出借人 2：借款人',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户密码',
  `nick_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `id_card` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `openid` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信用户标识openid',
  `head_img` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `bind_status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '绑定状态（0：未绑定，1：绑定成功 -1：绑定失败）',
  `borrow_auth_status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '借款人认证状态（0：未认证 1：认证中 2：认证通过 -1：认证失败）',
  `bind_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '绑定账户协议号',
  `integral` int(0) NOT NULL DEFAULT 0 COMMENT '用户积分',
  `status` tinyint(0) NOT NULL DEFAULT 1 COMMENT '状态（0：锁定 1：正常）',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户基本信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, 1, '17683004246', 'e10adc3949ba59abbe56e057f20f883e', '17683004246', '小明', NULL, NULL, NULL, 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/avatar/nilu.jpg', 0, 0, NULL, 0, 1, '2022-07-13 14:55:43', '2022-07-25 12:10:25', 0);
INSERT INTO `user_info` VALUES (2, 2, '18482020182', 'e10adc3949ba59abbe56e057f20f883e', '18482020182', '小王', '111222333444555', NULL, NULL, 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/avatar/nilu.jpg', 1, 2, '81f40b6f1bb341969bdce1827b317efb', 220, 1, '2022-07-14 21:24:16', '2022-07-24 12:55:30', 0);
INSERT INTO `user_info` VALUES (3, 1, '17683004240', 'e10adc3949ba59abbe56e057f20f883e', '17683004240', '小红', '510522222222222222', NULL, NULL, 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/avatar/nilu.jpg', 1, 0, 'ddd1066e996f45a5bf735d54deff86b5', 0, 1, '2022-07-26 18:29:35', '2022-07-26 18:29:35', 0);
INSERT INTO `user_info` VALUES (4, 2, '18482020180', 'e10adc3949ba59abbe56e057f20f883e', '18482020180', '小李', '510511111111111111', NULL, NULL, 'https://srb-file-dx.oss-cn-hangzhou.aliyuncs.com/avatar/nilu.jpg', 1, 2, '08c679e45f924926a2b91c10afb8b192', 220, 1, '2022-07-26 18:36:57', '2022-07-26 18:36:57', 0);

-- ----------------------------
-- Table structure for user_integral
-- ----------------------------
DROP TABLE IF EXISTS `user_integral`;
CREATE TABLE `user_integral`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户id',
  `integral` int(0) NULL DEFAULT NULL COMMENT '积分',
  `content` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '获取积分说明',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户积分记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_integral
-- ----------------------------
INSERT INTO `user_integral` VALUES (21, 2, 30, '借款人基本信息', '2022-07-24 17:39:56', '2022-07-24 17:39:56', 0);
INSERT INTO `user_integral` VALUES (22, 2, 30, '借款人身份证信息', '2022-07-24 17:39:56', '2022-07-24 17:39:56', 0);
INSERT INTO `user_integral` VALUES (23, 2, 100, '借款人房产信息', '2022-07-24 17:39:56', '2022-07-24 17:39:56', 0);
INSERT INTO `user_integral` VALUES (24, 2, 60, '借款人车辆信息', '2022-07-24 17:39:56', '2022-07-24 17:39:56', 0);
INSERT INTO `user_integral` VALUES (25, 4, 30, '借款人基本信息', '2022-07-26 18:51:06', '2022-07-26 18:51:06', 0);
INSERT INTO `user_integral` VALUES (26, 4, 30, '借款人身份证信息', '2022-07-26 18:51:06', '2022-07-26 18:51:06', 0);
INSERT INTO `user_integral` VALUES (27, 4, 100, '借款人房产信息', '2022-07-26 18:51:06', '2022-07-26 18:51:06', 0);
INSERT INTO `user_integral` VALUES (28, 4, 60, '借款人车辆信息', '2022-07-26 18:51:06', '2022-07-26 18:51:06', 0);

-- ----------------------------
-- Table structure for user_login_record
-- ----------------------------
DROP TABLE IF EXISTS `user_login_record`;
CREATE TABLE `user_login_record`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户id',
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户登录记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_login_record
-- ----------------------------
INSERT INTO `user_login_record` VALUES (29, 1, '0:0:0:0:0:0:0:1', '2022-07-13 16:51:49', '2022-07-13 16:51:49', 0);
INSERT INTO `user_login_record` VALUES (30, 1, '0:0:0:0:0:0:0:1', '2022-07-13 16:55:24', '2022-07-13 16:55:24', 0);
INSERT INTO `user_login_record` VALUES (31, 1, '0:0:0:0:0:0:0:1', '2022-07-13 16:59:28', '2022-07-13 16:59:28', 0);
INSERT INTO `user_login_record` VALUES (32, 1, '127.0.0.1', '2022-07-14 08:05:27', '2022-07-14 08:05:27', 0);
INSERT INTO `user_login_record` VALUES (33, 1, '0:0:0:0:0:0:0:1', '2022-07-14 08:13:35', '2022-07-14 08:13:35', 0);
INSERT INTO `user_login_record` VALUES (34, 1, '0:0:0:0:0:0:0:1', '2022-07-14 10:08:01', '2022-07-14 10:08:01', 0);
INSERT INTO `user_login_record` VALUES (35, 1, '0:0:0:0:0:0:0:1', '2022-07-14 10:09:01', '2022-07-14 10:09:01', 0);
INSERT INTO `user_login_record` VALUES (36, 1, '0:0:0:0:0:0:0:1', '2022-07-14 10:14:37', '2022-07-14 10:14:37', 0);
INSERT INTO `user_login_record` VALUES (37, 2, '192.168.191.1', '2022-07-14 21:24:28', '2022-07-14 21:24:28', 0);
INSERT INTO `user_login_record` VALUES (38, 2, '192.168.191.1', '2022-07-15 14:38:56', '2022-07-15 14:38:56', 0);
INSERT INTO `user_login_record` VALUES (39, 2, '192.168.191.1', '2022-07-15 20:28:29', '2022-07-15 20:28:29', 0);
INSERT INTO `user_login_record` VALUES (40, 2, '192.168.191.1', '2022-07-24 20:11:35', '2022-07-24 20:11:35', 0);
INSERT INTO `user_login_record` VALUES (41, 2, '192.168.191.1', '2022-07-24 21:06:24', '2022-07-24 21:06:24', 0);
INSERT INTO `user_login_record` VALUES (42, 2, '192.168.191.1', '2022-07-24 21:09:16', '2022-07-24 21:09:16', 0);
INSERT INTO `user_login_record` VALUES (43, 2, '192.168.191.1', '2022-07-25 09:28:22', '2022-07-25 09:28:22', 0);
INSERT INTO `user_login_record` VALUES (44, 1, '192.168.191.1', '2022-07-25 16:10:14', '2022-07-25 16:10:14', 0);
INSERT INTO `user_login_record` VALUES (45, 3, '192.168.191.1', '2022-07-26 18:33:06', '2022-07-26 18:33:06', 0);
INSERT INTO `user_login_record` VALUES (46, 4, '192.168.191.1', '2022-07-26 18:37:06', '2022-07-26 18:37:06', 0);
INSERT INTO `user_login_record` VALUES (47, 4, '192.168.191.1', '2022-07-27 09:37:58', '2022-07-27 09:37:58', 0);
INSERT INTO `user_login_record` VALUES (48, 2, '192.168.191.1', '2022-07-27 09:52:36', '2022-07-27 09:52:36', 0);
INSERT INTO `user_login_record` VALUES (49, 4, '192.168.191.1', '2022-07-27 09:55:12', '2022-07-27 09:55:12', 0);
INSERT INTO `user_login_record` VALUES (50, 3, '192.168.191.1', '2022-07-27 10:03:24', '2022-07-27 10:03:24', 0);
INSERT INTO `user_login_record` VALUES (51, 2, '192.168.191.1', '2022-07-27 10:14:57', '2022-07-27 10:14:57', 0);
INSERT INTO `user_login_record` VALUES (52, 2, '192.168.191.1', '2022-07-27 10:15:15', '2022-07-27 10:15:15', 0);
INSERT INTO `user_login_record` VALUES (53, 2, '192.168.191.1', '2022-07-27 10:15:20', '2022-07-27 10:15:20', 0);
INSERT INTO `user_login_record` VALUES (54, 2, '192.168.191.1', '2022-07-27 10:15:59', '2022-07-27 10:15:59', 0);
INSERT INTO `user_login_record` VALUES (55, 2, '192.168.191.1', '2022-07-27 10:17:59', '2022-07-27 10:17:59', 0);
INSERT INTO `user_login_record` VALUES (56, 2, '192.168.191.1', '2022-07-27 10:17:59', '2022-07-27 10:17:59', 0);
INSERT INTO `user_login_record` VALUES (57, 2, '192.168.191.1', '2022-07-27 10:17:59', '2022-07-27 10:17:59', 0);
INSERT INTO `user_login_record` VALUES (58, 2, '192.168.191.1', '2022-07-27 10:17:59', '2022-07-27 10:17:59', 0);
INSERT INTO `user_login_record` VALUES (59, 2, '192.168.191.1', '2022-07-27 10:18:16', '2022-07-27 10:18:16', 0);
INSERT INTO `user_login_record` VALUES (60, 2, '192.168.191.1', '2022-07-27 10:25:28', '2022-07-27 10:25:28', 0);
INSERT INTO `user_login_record` VALUES (61, 1, '192.168.191.1', '2022-07-27 10:28:06', '2022-07-27 10:28:06', 0);
INSERT INTO `user_login_record` VALUES (62, 2, '192.168.191.1', '2022-07-27 10:28:49', '2022-07-27 10:28:49', 0);
INSERT INTO `user_login_record` VALUES (63, 3, '192.168.191.1', '2022-07-27 10:31:46', '2022-07-27 10:31:46', 0);
INSERT INTO `user_login_record` VALUES (64, 2, '192.168.191.1', '2022-07-27 10:34:23', '2022-07-27 10:34:23', 0);

SET FOREIGN_KEY_CHECKS = 1;
