/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : rental_platform

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 27/05/2023 00:54:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for administrator
-- ----------------------------
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Role` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `Admin_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '管理员ID',
  `UserName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '账号',
  `UserPassword` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '区域',
  `AreaID` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '区域ID',
  `Tel` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `Avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `InChargeStaffID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `InChargeStaffName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE,
  INDEX `Admin_ID`(`Admin_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of administrator
-- ----------------------------
INSERT INTO `administrator` VALUES (1, 'staff', '工作人员1号', 'staff@01', 'Staff@01_2023', 'Staff@01_2023', '法仔庄', '01', '13763334852', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/6c3e6b13gy1h7wmgrfzcdj20u00u0wjh.jpg', '女', '下周辞职不是的', NULL, NULL);
INSERT INTO `administrator` VALUES (2, 'landlord', '梁爷爷', 'landlord#001', 'LeungGrandpa34', 'LeungGrandpa34', '法仔庄', '01', '13763334891', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/6c3e6b13gy1h7wmgrfzcdj20u00u0wjh.jpg', '女', '家有一老如有一宝', 'staff@01', '工作人员1号');
INSERT INTO `administrator` VALUES (3, 'landlord', '梁大海', 'landlord#002', 'DaihoiLeung70', 'DaihoiLeung70', '法仔庄', '01', '13422198198', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/FHbEyZ0WQAQHYcD.jpg', '女', 'none', 'staff@01', '工作人员1号');
INSERT INTO `administrator` VALUES (4, 'landlord', '梁超妍', 'landlord#003', 'LeungChiuYan_01', 'LeungChiuYan_01', '法仔庄', '01', '13455873953', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/Fab0gY2VEAAQBpn.jfif', '男', '啊for防for', 'staff@01', '工作人员1号');
INSERT INTO `administrator` VALUES (5, 'staff', '工作人员2号', 'staff@02', 'Staff@02_2023', 'Staff@02_2023', '矜用庄', '11', '13722198198', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/a709dbfagy1h4a5y2a1h0j20cu0fuaav.jpg', '女', 'Baby', '', NULL);
INSERT INTO `administrator` VALUES (6, 'landlord', '梁茶', 'landlord#101', 'Leung_Tea333', 'Leung_Tea333', '矜用庄', '11', '13763334852', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/005xP5xWgy1gxlaso6d2oj30t612wtev.jpg', '女', '悄然不动产', 'staff@02', '工作人员2号');
INSERT INTO `administrator` VALUES (7, 'landlord', '梁瞌睡', 'landlord#102', 'Jungkook97', 'Jungkook97', '矜用庄', '11', '13763362944', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/e8269ad0ly1gxay9d8pjfj20h00f03zl.jpg', '男', 'Fake love', 'staff@02', '工作人员2号');
INSERT INTO `administrator` VALUES (8, 'visitor', '张敬轩', '', 'HinsCheung1', 'HinsCheung1', ' ', ' ', '13873339293', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `administrator` VALUES (9, 'visitor', 'JKkookKE', '', 'JKkookKE25', 'JKkookKE25', '', '', '13873339293', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `administrator` VALUES (10, 'visitor', '悄然不动产', '', 'BBBBBB1', 'BBBBBB1', '', '', '13764947592', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `administrator` VALUES (11, 'visitor', '我不会起名', '', 'AAAAAA1', 'AAAAAA1', '', '', '19739839533', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `administrator` VALUES (12, 'landlord', '梁旭', 'landlord#004', 'testAccount9', 'testAccount9', '法仔庄', '01', '13455873925', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/72061a23ly1h9ritnhh5hj20u0140gum.jpg', '男', '以后一起玩', 'staff@01', '工作人员1号');
INSERT INTO `administrator` VALUES (13, 'landlord', '梁伟文', 'landlord#103', 'testAccount10', 'testAccount10', '矜用庄', '11', '13455873925', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/Fab0gY2VEAAQBpn.jfif', '女', '清醒点清醒点', 'staff@02', '工作人员2号');
INSERT INTO `administrator` VALUES (15, 'landlord', '梁小姐', 'landlord#104', 'testAccount11', 'testAccount11', '矜用庄', '11', '13455873925', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/Fab0gY2VEAAQBpn.jfif', '男', '清醒点清醒点', 'staff@02', '工作人员2号');
INSERT INTO `administrator` VALUES (16, 'landlord', '梁天赋', 'landlord#105', 'testAccount12', 'testAccount12', '矜用庄', '11', '13455873925', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/Fab0gY2VEAAQBpn.jfif', '男', '清醒点清醒点', 'staff@02', '工作人员2号');
INSERT INTO `administrator` VALUES (17, 'visitor', 'abc', '', 'hiWeAreBTS13', 'hiWeAreBTS13', '', '', '13762248722', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for booking
-- ----------------------------
DROP TABLE IF EXISTS `booking`;
CREATE TABLE `booking`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Staff_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员ID',
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Landlord_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房东ID',
  `Landlord_Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BookingStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '\"所有预约\", \"确认\", \"拒绝\", \"完成\", \"提交预约\"',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '访客姓名',
  `Contact` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '手机号',
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '预约时间',
  `Roomtype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Requirement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '具体需求',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booking
-- ----------------------------
INSERT INTO `booking` VALUES (2, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '提交预约', '林家谦', '13285858322', '男', '2023-03-13', '两房一厅', '');
INSERT INTO `booking` VALUES (3, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '确认', '戳爷洗碗', '18739275324', '男', '2023-03-14', '单间', '必须有空调');
INSERT INTO `booking` VALUES (5, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '确认', '张敬轩', '13873339293', '男', '2023-04-05', '单间', '');
INSERT INTO `booking` VALUES (6, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '提交预约', '张敬轩', '13873339293', '女', '2023-04-05', '一房一厅', '');
INSERT INTO `booking` VALUES (7, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '完成', '张敬轩', '13873339293', '男', '2023-04-03', '两房一厅', '');
INSERT INTO `booking` VALUES (9, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '提交预约', '张敬轩', '13873339293', '男', '2023-04-04', '单间', '');
INSERT INTO `booking` VALUES (10, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '拒绝', '张敬轩', '13873339293', '女', '2023-04-05', '一房一厅', '');
INSERT INTO `booking` VALUES (11, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '拒绝', 'JKkookKE', '13873339293', '女', '2023-04-06', '单间', '');
INSERT INTO `booking` VALUES (13, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '确认', 'JKkookKE', '13873339293', '女', '2023-05-18', '两房一厅', 'test');
INSERT INTO `booking` VALUES (15, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '完成', 'JKkookKE', '13873339293', '女', '2023-04-05', '单间', '');
INSERT INTO `booking` VALUES (17, 'staff@01', '法仔庄', 'landlord#003', '梁超妍', '提交预约', 'JKkookKE', '13873339293', '男', '2023-05-07', '一房一厅', 'hello');
INSERT INTO `booking` VALUES (21, 'staff@01', '法仔庄', 'landlord#003', '梁超妍', '提交预约', 'JKkookKE', '13873339293', '女', '2023-02-08', '一房一厅', '');
INSERT INTO `booking` VALUES (23, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', 'JKkookKE', '13873339293', '男', '2023-03-03', '一房一厅', '');
INSERT INTO `booking` VALUES (24, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '确认', 'JKkookKE', '13873339293', '男', '2023-03-10', '单间', '');
INSERT INTO `booking` VALUES (25, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', 'JKkookKE', '13873339293', '女', '2023-03-16', '单间', '');
INSERT INTO `booking` VALUES (26, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '完成', 'JKkookKE', '13873339293', '男', '2022-10-04', '两房一厅', '');
INSERT INTO `booking` VALUES (27, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '拒绝', 'JKkookKE', '13873339293', '女', '2023-05-06', '一房一厅', '');
INSERT INTO `booking` VALUES (28, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', 'JKkookKE', '13873339293', '女', '2023-05-25', '单间', '测试');
INSERT INTO `booking` VALUES (29, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '拒绝', 'JKkookKE', '13873339293', '女', '2023-01-07', '一房一厅', '无');
INSERT INTO `booking` VALUES (30, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', '悄然不动产', '13764947592', '男', '2023-05-02', '单间', '空调空调');
INSERT INTO `booking` VALUES (31, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', '悄然不动产', '13764947592', '女', '2023-03-12', '两房一厅', '无');
INSERT INTO `booking` VALUES (32, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', '悄然不动产', '13764947592', '男', '2023-02-17', '两房一厅', '再说');
INSERT INTO `booking` VALUES (33, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', '悄然不动产', '13764947592', '女', '2023-02-04', '一房一厅', '急！');
INSERT INTO `booking` VALUES (34, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '完成', '悄然不动产', '13764947592', '男', '2023-05-02', '单间', '无');
INSERT INTO `booking` VALUES (35, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '提交预约', '悄然不动产', '13764947592', '女', '2023-05-13', '一房一厅', '再说');
INSERT INTO `booking` VALUES (36, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '提交预约', '悄然不动产', '13764947592', '女', '2022-12-03', '两房一厅', '再说');
INSERT INTO `booking` VALUES (37, 'staff@01', '法仔庄', 'landlord#003', '梁超妍', '提交预约', '悄然不动产', '13764947592', '女', '2023-05-03', 'test', '');
INSERT INTO `booking` VALUES (38, 'staff@01', '法仔庄', 'landlord#003', '梁超妍', '提交预约', '悄然不动产', '13764947592', '男', '2023-05-02', '单间', '');
INSERT INTO `booking` VALUES (39, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '完成', '悄然不动产', '13764947592', '男', '2023-05-01', '两房一厅', '');
INSERT INTO `booking` VALUES (40, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '提交预约', '悄然不动产', '13764947592', '女', '2023-05-06', '一房一厅', '再说');
INSERT INTO `booking` VALUES (41, 'staff@02', '矜用庄', 'landlord#101', '梁茶', '提交预约', '悄然不动产', '13764947592', '男', '2023-05-02', '两房一厅', '');
INSERT INTO `booking` VALUES (42, 'staff@02', '矜用庄', 'landlord#101', '梁茶', '提交预约', '悄然不动产', '13764947592', '女', '2023-05-06', '一房一厅', '');
INSERT INTO `booking` VALUES (43, 'staff@02', '矜用庄', 'landlord#101', '梁茶', '提交预约', '悄然不动产', '13764947592', '女', '2023-05-03', '单间', '');
INSERT INTO `booking` VALUES (46, 'staff@01', '法仔庄', 'landlord#004', '梁旭', '提交预约', '我不会起名', '19739839533', '女', '2023-05-03', '单间', '');
INSERT INTO `booking` VALUES (47, 'staff@01', '法仔庄', 'landlord#004', '梁旭', '确认', '我不会起名', '19739839533', '男', '2023-03-01', '两房一厅', '');
INSERT INTO `booking` VALUES (48, 'staff@01', '法仔庄', 'landlord#004', '梁旭', '确认', '我不会起名', '19739839533', '女', '2023-05-06', '一房一厅', '');
INSERT INTO `booking` VALUES (49, 'staff@01', '法仔庄', 'landlord#004', '梁旭', '提交预约', '我不会起名', '19739839533', '男', '2023-01-11', 'test', '');
INSERT INTO `booking` VALUES (50, 'staff@01', '法仔庄', 'landlord#004', '梁旭', '拒绝', '我不会起名', '19739839533', '女', '2023-02-11', '单间', '');
INSERT INTO `booking` VALUES (51, 'staff@01', '法仔庄', 'landlord#004', '梁旭', '完成', '我不会起名', '19739839533', '男', '2023-01-07', '一房一厅', '');
INSERT INTO `booking` VALUES (52, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '提交预约', '我不会起名', '19739839533', '男', '2023-05-02', '一房一厅', '');
INSERT INTO `booking` VALUES (53, 'staff@02', '矜用庄', 'landlord#102', '梁超妍', '拒绝', '我不会起名', '19739839533', '女', '2023-05-06', '单间', '');
INSERT INTO `booking` VALUES (54, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '确认', '我不会起名', '19739839533', '男', '2023-05-02', '单间', '');
INSERT INTO `booking` VALUES (56, 'staff@02', '矜用庄', 'landlord#104', '梁小姐', '提交预约', 'abc', '13762248722', '女', '2023-05-03', '单间', '');
INSERT INTO `booking` VALUES (57, 'staff@02', '矜用庄', 'landlord#104', '梁小姐', '提交预约', 'abc', '13762248722', '男', '2023-03-15', '一房一厅', '');
INSERT INTO `booking` VALUES (58, 'staff@02', '矜用庄', 'landlord#103', '梁伟文', '提交预约', 'abc', '13762248722', '女', '2023-04-16', '单间', '');
INSERT INTO `booking` VALUES (59, 'staff@02', '矜用庄', 'landlord#101', '梁茶', '提交预约', 'abc', '13762248722', '男', '2023-05-01', '两房一厅', '');
INSERT INTO `booking` VALUES (60, 'staff@01', '法仔庄', 'landlord#002', '梁大海', '提交预约', 'abc', '13762248722', '男', '2023-05-05', '单间', '');
INSERT INTO `booking` VALUES (61, 'staff@01', '法仔庄', 'landlord#004', '梁旭', '提交预约', 'abc', '13762248722', '女', '2023-05-02', '两房一厅', '');
INSERT INTO `booking` VALUES (62, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', 'abc', '13762248722', '男', '2023-05-01', '两房一厅', '');
INSERT INTO `booking` VALUES (63, 'staff@01', '法仔庄', 'landlord#003', '梁超妍', '提交预约', '张敬轩', '13873339293', '女', '2023-05-02', '一房一厅', '');
INSERT INTO `booking` VALUES (64, 'staff@01', '法仔庄', 'landlord#001', '梁爷爷', '提交预约', 'JKkookKE', '13873339293', '男', '2023-05-14', '单间', 'test');

-- ----------------------------
-- Table structure for contract_landlord#001
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#001`;
CREATE TABLE `contract_landlord#001`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#001
-- ----------------------------
INSERT INTO `contract_landlord#001` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约结束', '13456436742', '');
INSERT INTO `contract_landlord#001` VALUES (28, '603', '一房一厅', '440214564235345342', 'test - rentDelete', '3', '2023-04-05', '半年', '850', '两押一租', '1700', '每月6号', '15', '30', '3', '3', '租约结束', '18745453122', '');
INSERT INTO `contract_landlord#001` VALUES (29, '503', '单间', '440121121212121212', 'test - wholeRent', '3', '2023-03-12', '半年', '650', '两押一租', '1300', '每月12号', '20', '50', '4', '1', '租约结束', '13445465789', '');
INSERT INTO `contract_landlord#001` VALUES (30, '501', '一房一厅', '440114897939383833', 'test - rent', '1', '2022-11-05', '一年', '1000', '两押一租', '2000', '每月6号', '20', '50', '4', '2', '租约结束', '13423222222', '');
INSERT INTO `contract_landlord#001` VALUES (31, '602', '单间', '421565656565656565', 't tenant1', '1', '2023-03-01', '半年', '600', '两押一租', '1200', '每月30号', '20', '50', '4', '2', '租约中', '13498989898', '');
INSERT INTO `contract_landlord#001` VALUES (32, '603', '一房一厅', '440198444444444444', 't tenant2', '2', '2022-06-10', '一年', '850', '两押一租', '1700', '每月30号', '20', '50', '4', '1.5', '租约结束', '13787878781', '');
INSERT INTO `contract_landlord#001` VALUES (34, '403', '一房一厅', '440121989898989898', 'test t', '2', '2022-10-02', '一年', '1100', '两押一租', '2200', '每月 1号', '25', '50', '4', '1.5', '租约结束', '13987878787', '');
INSERT INTO `contract_landlord#001` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#001` VALUES (36, '504', '单间', '440343434343434343', 't', '2', '2023-01-08', '5个月', '600', '两押一租', '1200', '每月9号', '20', '50', '5', '2', '租约结束', '13467565656', '');
INSERT INTO `contract_landlord#001` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约中', '13198324242', '');
INSERT INTO `contract_landlord#001` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#001` VALUES (40, '504', '单间', '440221787875757575', '梁超妍', '1', '2023-04-02', '3个月', '600', '两押一租', '1200', '每月30号', '1', '1', '1', '1', '租约结束', '15733333333', '');
INSERT INTO `contract_landlord#001` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约中', '13422986743', '');
INSERT INTO `contract_landlord#001` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约中', '13763334852', '');
INSERT INTO `contract_landlord#001` VALUES (44, '606', '一房一厅', '440121200001010422', '罗杰夫', '1', '2023-02-15', '半年', '900', '两押一租', '1800', '每月15号', '30', '40', '4', '2', '租约中', '13764487294', '');
INSERT INTO `contract_landlord#001` VALUES (45, '404', '单间', '440114200109270429', '陈奕迅', '1', '2022-11-02', '7个月', '650', '两押一租 ', '1300', '每月2号', '30', '50', '4', '2', '租约中', '13769927493', '');

-- ----------------------------
-- Table structure for contract_landlord#002
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#002`;
CREATE TABLE `contract_landlord#002`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#002
-- ----------------------------
INSERT INTO `contract_landlord#002` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约结束', '13456436742', '');
INSERT INTO `contract_landlord#002` VALUES (32, '603', '一房一厅', '440198444444444444', 't tenant2', '2', '2022-06-10', '一年', '850', '两押一租', '1700', '每月30号', '20', '50', '4', '1.5', '租约结束', '13787878781', '');
INSERT INTO `contract_landlord#002` VALUES (34, '403', '一房一厅', '440121989898989898', 'test t', '2', '2022-10-02', '一年', '1100', '两押一租', '2200', '每月 1号', '25', '50', '4', '1.5', '租约结束', '13987878787', '');
INSERT INTO `contract_landlord#002` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#002` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约中', '13198324242', '');
INSERT INTO `contract_landlord#002` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#002` VALUES (40, '504', '单间', '440221787875757575', '梁超妍', '1', '2023-04-02', '3个月', '600', '两押一租', '1200', '每月30号', '1', '1', '1', '1', '租约结束', '15733333333', '');
INSERT INTO `contract_landlord#002` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约中', '13422986743', '');
INSERT INTO `contract_landlord#002` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约结束', '13763334852', '');
INSERT INTO `contract_landlord#002` VALUES (44, '606', '一房一厅', '440121200001010422', '罗杰夫', '1', '2023-02-15', '半年', '900', '两押一租', '1800', '每月15号', '30', '40', '4', '2', '租约中', '13764487294', '');
INSERT INTO `contract_landlord#002` VALUES (45, '401', '两房一厅', '440114200304938213', '孙尚香', '1', '2023-03-08', '半年', '1500', '三押一租', '4500', '每月 8号', '20', '40', '4', '2', '租约中', '13874492753', '');
INSERT INTO `contract_landlord#002` VALUES (46, '404', '单间', '440114200893859333', '小梁', '1', '2023-05-02', '4个月', '650', '两押一租 ', '1300', '每月3号', '40', '30', '4', '2', '租约中', '13875558244', '');
INSERT INTO `contract_landlord#002` VALUES (47, 'test', 'test', '449114939393939393', '小罗', '1', '2023-04-09', '半年', 'test', 'test', 'test', 'test', '20', '50', '4', '1', '租约结束', '13522222222', '');

-- ----------------------------
-- Table structure for contract_landlord#003
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#003`;
CREATE TABLE `contract_landlord#003`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#003
-- ----------------------------
INSERT INTO `contract_landlord#003` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约中', '13456436742', '');
INSERT INTO `contract_landlord#003` VALUES (28, '603', '一房一厅', '440214564235345342', 'test - rentDelete', '3', '2023-04-05', '半年', '850', '两押一租', '1700', '每月6号', '15', '30', '3', '3', '租约结束', '18745453122', '');
INSERT INTO `contract_landlord#003` VALUES (29, '503', '单间', '440121121212121212', 'test - wholeRent', '3', '2023-03-12', '半年', '650', '两押一租', '1300', '每月12号', '20', '50', '4', '1', '租约结束', '13445465789', '');
INSERT INTO `contract_landlord#003` VALUES (30, '501', '一房一厅', '440114897939383833', 'test - rent', '1', '2022-11-05', '一年', '1000', '两押一租', '2000', '每月6号', '20', '50', '4', '2', '租约结束', '13423222222', '');
INSERT INTO `contract_landlord#003` VALUES (31, '602', '单间', '421565656565656565', 't tenant1', '1', '2023-03-01', '半年', '600', '两押一租', '1200', '每月30号', '20', '50', '4', '2', '租约中', '13498989898', '');
INSERT INTO `contract_landlord#003` VALUES (32, '603', '一房一厅', '440198444444444444', 't tenant2', '2', '2022-06-10', '一年', '850', '两押一租', '1700', '每月30号', '20', '50', '4', '1.5', '租约结束', '13787878781', '');
INSERT INTO `contract_landlord#003` VALUES (34, '403', '一房一厅', '440121989898989898', 'test t', '2', '2022-10-02', '一年', '1100', '两押一租', '2200', '每月 1号', '25', '50', '4', '1.5', '租约结束', '13987878787', '');
INSERT INTO `contract_landlord#003` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#003` VALUES (36, '504', '单间', '440343434343434343', 't', '2', '2023-01-08', '5个月', '600', '两押一租', '1200', '每月9号', '20', '50', '5', '2', '租约结束', '13467565656', '');
INSERT INTO `contract_landlord#003` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约中', '13198324242', '');
INSERT INTO `contract_landlord#003` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#003` VALUES (40, '504', '单间', '440221787875757575', '梁超妍', '1', '2023-04-02', '3个月', '600', '两押一租', '1200', '每月30号', '1', '1', '1', '1', '租约结束', '15733333333', '');
INSERT INTO `contract_landlord#003` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约中', '13422986743', '');
INSERT INTO `contract_landlord#003` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约中', '13763334852', '');
INSERT INTO `contract_landlord#003` VALUES (44, '606', '一房一厅', '440121200001010422', '罗杰夫', '1', '2023-02-15', '半年', '900', '两押一租', '1800', '每月15号', '30', '40', '4', '2', '租约中', '13764487294', '');

-- ----------------------------
-- Table structure for contract_landlord#004
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#004`;
CREATE TABLE `contract_landlord#004`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#004
-- ----------------------------
INSERT INTO `contract_landlord#004` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约中', '13456436742', '');
INSERT INTO `contract_landlord#004` VALUES (28, '603', '一房一厅', '440214564235345342', 'test - rentDelete', '3', '2023-04-05', '半年', '850', '两押一租', '1700', '每月6号', '15', '30', '3', '3', '租约结束', '18745453122', '');
INSERT INTO `contract_landlord#004` VALUES (29, '503', '单间', '440121121212121212', 'test - wholeRent', '3', '2023-03-12', '半年', '650', '两押一租', '1300', '每月12号', '20', '50', '4', '1', '租约结束', '13445465789', '');
INSERT INTO `contract_landlord#004` VALUES (30, '501', '一房一厅', '440114897939383833', 'test - rent', '1', '2022-11-05', '一年', '1000', '两押一租', '2000', '每月6号', '20', '50', '4', '2', '租约结束', '13423222222', '');
INSERT INTO `contract_landlord#004` VALUES (31, '602', '单间', '421565656565656565', 't tenant1', '1', '2023-03-01', '半年', '600', '两押一租', '1200', '每月30号', '20', '50', '4', '2', '租约中', '13498989898', '');
INSERT INTO `contract_landlord#004` VALUES (32, '603', '一房一厅', '440198444444444444', 't tenant2', '2', '2022-06-10', '一年', '850', '两押一租', '1700', '每月30号', '20', '50', '4', '1.5', '租约结束', '13787878781', '');
INSERT INTO `contract_landlord#004` VALUES (34, '403', '一房一厅', '440121989898989898', 'test t', '2', '2022-10-02', '一年', '1100', '两押一租', '2200', '每月 1号', '25', '50', '4', '1.5', '租约结束', '13987878787', '');
INSERT INTO `contract_landlord#004` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#004` VALUES (36, '504', '单间', '440343434343434343', 't', '2', '2023-01-08', '5个月', '600', '两押一租', '1200', '每月9号', '20', '50', '5', '2', '租约结束', '13467565656', '');
INSERT INTO `contract_landlord#004` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约中', '13198324242', '');
INSERT INTO `contract_landlord#004` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#004` VALUES (40, '504', '单间', '440221787875757575', '梁超妍', '1', '2023-04-02', '3个月', '600', '两押一租', '1200', '每月30号', '1', '1', '1', '1', '租约结束', '15733333333', '');
INSERT INTO `contract_landlord#004` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约中', '13422986743', '');
INSERT INTO `contract_landlord#004` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约中', '13763334852', '');
INSERT INTO `contract_landlord#004` VALUES (44, '606', '一房一厅', '440121200001010422', '罗杰夫', '1', '2023-02-15', '半年', '900', '两押一租', '1800', '每月15号', '30', '40', '4', '2', '租约中', '13764487294', '');

-- ----------------------------
-- Table structure for contract_landlord#101
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#101`;
CREATE TABLE `contract_landlord#101`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#101
-- ----------------------------
INSERT INTO `contract_landlord#101` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约中', '13456436742', '');
INSERT INTO `contract_landlord#101` VALUES (30, '501', '一房一厅', '440114897939383833', 'test - rent', '1', '2022-11-05', '一年', '1000', '两押一租', '2000', '每月6号', '20', '50', '4', '2', '租约结束', '13423222222', '');
INSERT INTO `contract_landlord#101` VALUES (31, '602', '单间', '421565656565656565', 't tenant1', '1', '2023-03-01', '半年', '600', '两押一租', '1200', '每月30号', '20', '50', '4', '2', '租约中', '13498989898', '');
INSERT INTO `contract_landlord#101` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#101` VALUES (36, '504', '单间', '440343434343434343', 't', '2', '2023-01-08', '5个月', '600', '两押一租', '1200', '每月9号', '20', '50', '5', '2', '租约结束', '13467565656', '');
INSERT INTO `contract_landlord#101` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约中', '13198324242', '');
INSERT INTO `contract_landlord#101` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#101` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约结束', '13422986743', '');
INSERT INTO `contract_landlord#101` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约中', '13763334852', '');
INSERT INTO `contract_landlord#101` VALUES (45, '502', '一房一厅', '440114200109270429', '田柾国', '1', '2023-01-15', '一年', '900', '两押一租', '1800', '每月15号', '20', '50', '4', '1.5', '租约中', '13763334852', '');

-- ----------------------------
-- Table structure for contract_landlord#102
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#102`;
CREATE TABLE `contract_landlord#102`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#102
-- ----------------------------
INSERT INTO `contract_landlord#102` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约中', '13456436742', '');
INSERT INTO `contract_landlord#102` VALUES (30, '501', '一房一厅', '440114897939383833', 'test - rent', '1', '2022-11-05', '一年', '1000', '两押一租', '2000', '每月6号', '20', '50', '4', '2', '租约结束', '13423222222', '');
INSERT INTO `contract_landlord#102` VALUES (31, '602', '单间', '421565656565656565', 't tenant1', '1', '2023-03-01', '半年', '600', '两押一租', '1200', '每月30号', '20', '50', '4', '2', '租约中', '13498989898', '');
INSERT INTO `contract_landlord#102` VALUES (32, '603', '一房一厅', '440198444444444444', 't tenant2', '2', '2022-06-10', '一年', '850', '两押一租', '1700', '每月30号', '20', '50', '4', '1.5', '租约结束', '13787878781', '');
INSERT INTO `contract_landlord#102` VALUES (34, '403', '一房一厅', '440121989898989898', 'test t', '2', '2022-10-02', '一年', '1100', '两押一租', '2200', '每月 1号', '25', '50', '4', '1.5', '租约结束', '13987878787', '');
INSERT INTO `contract_landlord#102` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#102` VALUES (36, '504', '单间', '440343434343434343', 't', '2', '2023-01-08', '5个月', '600', '两押一租', '1200', '每月9号', '20', '50', '5', '2', '租约结束', '13467565656', '');
INSERT INTO `contract_landlord#102` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约结束', '13198324242', '');
INSERT INTO `contract_landlord#102` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#102` VALUES (40, '504', '单间', '440221787875757575', '梁超妍', '1', '2023-04-02', '3个月', '600', '两押一租', '1200', '每月30号', '1', '1', '1', '1', '租约结束', '15733333333', '');
INSERT INTO `contract_landlord#102` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约中', '13422986743', '');
INSERT INTO `contract_landlord#102` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约中', '13763334852', '');
INSERT INTO `contract_landlord#102` VALUES (44, '606', '一房一厅', '440121200001010422', '罗杰夫', '1', '2023-02-15', '半年', '900', '两押一租', '1800', '每月15号', '30', '40', '4', '2', '租约中', '13764487294', '');
INSERT INTO `contract_landlord#102` VALUES (45, '401', '两房一厅', '440114120492059305', 'test last', '2', '2023-04-01', '半年', '1500', '三押一租', '4500', '每月1号', '20', '50', '5', '2', '租约结束', '13453544332', '');

-- ----------------------------
-- Table structure for contract_landlord#103
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#103`;
CREATE TABLE `contract_landlord#103`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#103
-- ----------------------------
INSERT INTO `contract_landlord#103` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约中', '13456436742', '');
INSERT INTO `contract_landlord#103` VALUES (30, '501', '一房一厅', '440114897939383833', 'test - rent', '1', '2022-11-05', '一年', '1000', '两押一租', '2000', '每月6号', '20', '50', '4', '2', '租约结束', '13423222222', '');
INSERT INTO `contract_landlord#103` VALUES (31, '602', '单间', '421565656565656565', 't tenant1', '1', '2023-03-01', '半年', '600', '两押一租', '1200', '每月30号', '20', '50', '4', '2', '租约中', '13498989898', '');
INSERT INTO `contract_landlord#103` VALUES (32, '603', '一房一厅', '440198444444444444', 't tenant2', '2', '2022-06-10', '一年', '850', '两押一租', '1700', '每月30号', '20', '50', '4', '1.5', '租约结束', '13787878781', '');
INSERT INTO `contract_landlord#103` VALUES (34, '403', '一房一厅', '440121989898989898', 'test t', '2', '2022-10-02', '一年', '1100', '两押一租', '2200', '每月 1号', '25', '50', '4', '1.5', '租约结束', '13987878787', '');
INSERT INTO `contract_landlord#103` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#103` VALUES (36, '504', '单间', '440343434343434343', 't', '2', '2023-01-08', '5个月', '600', '两押一租', '1200', '每月9号', '20', '50', '5', '2', '租约结束', '13467565656', '');
INSERT INTO `contract_landlord#103` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约结束', '13198324242', '');
INSERT INTO `contract_landlord#103` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#103` VALUES (40, '504', '单间', '440221787875757575', '梁超妍', '1', '2023-04-02', '3个月', '600', '两押一租', '1200', '每月30号', '1', '1', '1', '1', '租约结束', '15733333333', '');
INSERT INTO `contract_landlord#103` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约中', '13422986743', '');
INSERT INTO `contract_landlord#103` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约中', '13763334852', '');
INSERT INTO `contract_landlord#103` VALUES (44, '606', '一房一厅', '440121200001010422', '罗杰夫', '1', '2023-02-15', '半年', '900', '两押一租', '1800', '每月15号', '30', '40', '4', '2', '租约中', '13764487294', '');
INSERT INTO `contract_landlord#103` VALUES (45, '401', '两房一厅', '440114120492059305', 'test last', '2', '2023-04-01', '半年', '1500', '三押一租', '4500', '每月1号', '20', '50', '5', '2', '租约结束', '13453544332', '');

-- ----------------------------
-- Table structure for contract_landlord#104
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#104`;
CREATE TABLE `contract_landlord#104`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#104
-- ----------------------------
INSERT INTO `contract_landlord#104` VALUES (27, '402', '两房一厅', '440123123123123123', 'test - duplicate TenantID', '2', '2023-01-20', '一年', '1500', '三押一租', '4500', '每月21号', '15', '50', '4', '1.5', '租约中', '13456436742', '');
INSERT INTO `contract_landlord#104` VALUES (30, '501', '一房一厅', '440114897939383833', 'test - rent', '1', '2022-11-05', '一年', '1000', '两押一租', '2000', '每月6号', '20', '50', '4', '2', '租约结束', '13423222222', '');
INSERT INTO `contract_landlord#104` VALUES (31, '602', '单间', '421565656565656565', 't tenant1', '1', '2023-03-01', '半年', '600', '两押一租', '1200', '每月30号', '20', '50', '4', '2', '租约中', '13498989898', '');
INSERT INTO `contract_landlord#104` VALUES (32, '603', '一房一厅', '440198444444444444', 't tenant2', '2', '2022-06-10', '一年', '850', '两押一租', '1700', '每月30号', '20', '50', '4', '1.5', '租约结束', '13787878781', '');
INSERT INTO `contract_landlord#104` VALUES (34, '403', '一房一厅', '440121989898989898', 'test t', '2', '2022-10-02', '一年', '1100', '两押一租', '2200', '每月 1号', '25', '50', '4', '1.5', '租约结束', '13987878787', '');
INSERT INTO `contract_landlord#104` VALUES (35, '601', '单间', '440121989898989898', 'tt', '1', '2022-05-07', '一年', '650', '两押一租', '1300', '每月 3号', '20', '50', '4', '2', '租约中', '13298989898', '');
INSERT INTO `contract_landlord#104` VALUES (36, '504', '单间', '440343434343434343', 't', '2', '2023-01-08', '5个月', '600', '两押一租', '1200', '每月9号', '20', '50', '5', '2', '租约结束', '13467565656', '');
INSERT INTO `contract_landlord#104` VALUES (37, '603', '一房一厅', '440112989843566545', 't0', '1', '2023-02-05', '4个月', '850', '两押一租', '1700', '每月5号', '25', '50', '4.5', '1.5', '租约结束', '13198324242', '');
INSERT INTO `contract_landlord#104` VALUES (38, '505', '单间', '440485878787878787', 'test -', '2', '2023-03-27', '4个月', '700', '两押一租 ', '1400', '每月30号', '20', '50', '4.5', '2', '租约中', '18765656565', '');
INSERT INTO `contract_landlord#104` VALUES (40, '504', '单间', '440221787875757575', '梁超妍', '1', '2023-04-02', '3个月', '600', '两押一租', '1200', '每月30号', '1', '1', '1', '1', '租约结束', '15733333333', '');
INSERT INTO `contract_landlord#104` VALUES (42, '501', '一房一厅', '440235445434311342', 'test 8', '2', '2023-04-01', '4个月', '1000', '两押一租', '2000', '每月30号', '20', '50', '4', '1.5', '租约中', '13422986743', '');
INSERT INTO `contract_landlord#104` VALUES (43, '403', '一房一厅', '440121200109270429', '梁超妍', '2', '2023-02-11', '半年', '1100', '两押一租', '2200', '每月12号', '20', '50', '4.5', '2', '租约中', '13763334852', '');
INSERT INTO `contract_landlord#104` VALUES (44, '606', '一房一厅', '440121200001010422', '罗杰夫', '1', '2023-02-15', '半年', '900', '两押一租', '1800', '每月15号', '30', '40', '4', '2', '租约中', '13764487294', '');
INSERT INTO `contract_landlord#104` VALUES (45, '401', '两房一厅', '440114120492059305', 'test last', '2', '2023-04-01', '半年', '1500', '三押一租', '4500', '每月1号', '20', '50', '5', '2', '租约结束', '13453544332', '');

-- ----------------------------
-- Table structure for contract_landlord#105
-- ----------------------------
DROP TABLE IF EXISTS `contract_landlord#105`;
CREATE TABLE `contract_landlord#105`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Room` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房型',
  `TenantID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Population` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实际租住人数',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月租',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收租日',
  `PublicCleanFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位水费',
  `UnitElectricityCharge` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位电费',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租约中、租约结束',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_landlord#105
-- ----------------------------

-- ----------------------------
-- Table structure for house
-- ----------------------------
DROP TABLE IF EXISTS `house`;
CREATE TABLE `house`  (
  `No` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `HouseNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '门牌号',
  `OwnerName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房东名字',
  `Landlord_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '管理员ID',
  `OwnerID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房东身份证号',
  `OverallSafetySituation` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '总体安全状况',
  `LastInspectedTime` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '上次巡查时间',
  `StaffName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员名字',
  `Staff_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员ID',
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '区域',
  `AreaID` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '区域ID',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '面积',
  `CompletionTime` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '建成时间',
  `Height` varchar(10) CHARACTER SET cp852 COLLATE cp852_general_ci NULL DEFAULT NULL COMMENT '楼高',
  `Floors` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '楼层数',
  `AvailableRooms` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '可出租房间数量',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`No`) USING BTREE,
  INDEX `house_landlord`(`Landlord_ID`) USING BTREE,
  INDEX `house_staff`(`Staff_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house
-- ----------------------------
INSERT INTO `house` VALUES (29, '七巷1号', '梁爷爷', 'landlord#001', '440121200011111111', '合格', '2020-07-09', '工作人员1号', 'staff@01', '法仔庄', '01', '300', '2023-03-28', '3', '3', '1', '');
INSERT INTO `house` VALUES (30, '八巷2号', '梁大海', 'landlord#002', '440121200011111111', '合格', '2023-03-09', '工作人员1号', 'staff@01', '法仔庄', '01', '500', '2021-02-03', '10', '4', '5', '');
INSERT INTO `house` VALUES (31, '五巷3号', '梁超妍', 'landlord#003', '440121193410183232', '合格', '2023-03-10', '工作人员1号', 'staff@01', '法仔庄', '01', '600', '2022-07-11', '10', '3.5', '0', '无');
INSERT INTO `house` VALUES (33, '二巷1号', '梁茶', 'landlord#101', '440121193410183232', '合格', '2023-03-04', '工作人员2号', 'staff@02', '矜用庄', '11', NULL, '2014-05-04', '14', '5', '8', '');
INSERT INTO `house` VALUES (34, '一巷5号', '梁超妍', 'landlord#102', '440121193410183232', '合格', '2023-03-04', '工作人员2号', 'staff@02', '矜用庄', '11', NULL, '2014-05-04', '14', '5', '8', '');
INSERT INTO `house` VALUES (35, '一巷6号', '梁旭', 'landlord#004', '441121989482264242', '合格', '2023-05-05', '工作人员1号', 'staff@01', '法仔庄', '01', NULL, '2023-05-01', '15', '5', '7', '');
INSERT INTO `house` VALUES (37, '0巷0号', '333', 'landlord#002', '333333333333333333', '存在隐患', '2023-05-04', '工作人员1号', 'staff@01', '法仔庄', '01', '0', '2023-05-01', '0', '0', '0', '');
INSERT INTO `house` VALUES (40, '二巷3号', '梁伟文', 'landlord#103', '440114200012038401', '合格', '2023-05-01', '工作人员2号', 'staff@02', '矜用庄', '11', '500', '2013-05-09', '15', '5', '10', '');
INSERT INTO `house` VALUES (41, '八巷3号', '梁小姐', 'landlord#104', '440121197009012844', '合格', '2023-03-18', '工作人员2号', 'staff@02', '矜用庄', '11', '300', '2013-04-01', '10', '3', '5', '');
INSERT INTO `house` VALUES (42, '五巷4号', '梁天赋', 'landlord#105', '440121198703129982', '合格', '2023-05-10', '工作人员2号', 'staff@02', '矜用庄', '11', '300', '2015-05-05', '10', '4', '5', '');

-- ----------------------------
-- Table structure for migrant
-- ----------------------------
DROP TABLE IF EXISTS `migrant`;
CREATE TABLE `migrant`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '姓名',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证',
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租期',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租约中，租约结束',
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '区域',
  `AreaID` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StaffName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Staff_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员ID',
  `Landlord_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房东ID',
  `LandlordName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '性别',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE,
  INDEX `migrant_landlord`(`Landlord_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrant
-- ----------------------------
INSERT INTO `migrant` VALUES (2, '田柾国', '440114199709013396', '2022-01-02', '一年', '租约结束', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '男', '13763334852', '单身未育', '釜山', ' ');
INSERT INTO `migrant` VALUES (6, '陈蕾', '440114199002183391', '2022-07-01', '半年', '租约结束', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#002', '梁大海', '女', '1322252567432', '单身已育', '澳门', '');
INSERT INTO `migrant` VALUES (9, '林嘉欣', '440114194447013396', '2023-01-07', '5个月', '租约结束', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '女', '1322252567432', '单身未育', '广州', '');
INSERT INTO `migrant` VALUES (10, '梁超妍', '440114175629013396', '2023-01-07', '3个月', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '女', '1322252567432', '单身未育', '广州', '');
INSERT INTO `migrant` VALUES (18, 'test - duplicate TenantID', '440123123123123123', '2023-01-20', '4个月', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '女', '13456436742', '已婚已育', '广东潮州', '');
INSERT INTO `migrant` VALUES (19, 't tenant1', '421565656565656565', '2023-03-01', '半年', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '男', '13498989898', '单身未育', '广州', '');
INSERT INTO `migrant` VALUES (20, 'test - rent', '440114897939383833', '2022-11-05', '一年', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '男', '13423222222', '单身未育', '新疆乌鲁木齐', '');
INSERT INTO `migrant` VALUES (21, 'test - rentDelete', '440214564235345342', '2023-04-05', '半年', '租约结束', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '女', '18745453122', '已婚未育', '广东东莞', '');
INSERT INTO `migrant` VALUES (22, '梁超妍', '440121200109270429', '2023-02-11', '半年', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#001', '梁爷爷', '男', '13763334852', '已婚未育', '上海', 'undefined');
INSERT INTO `migrant` VALUES (23, '罗杰夫', '440121200001010422', '2023-02-15', '半年', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#002', '梁大海', '男', '13764487294', '已婚未育', '山东', '');
INSERT INTO `migrant` VALUES (24, 'tt', '440121989898989898', '2022-05-07', '一年', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#003', '梁超妍', '男', '13298989898', '单身已育', '江门', '');
INSERT INTO `migrant` VALUES (25, 'tt', '440121989898989898', '2022-05-07', '一年', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#002', '梁大海', '男', '13298989898', '单身未育', '揭阳', '');
INSERT INTO `migrant` VALUES (26, 't0', '440112989843566545', '2023-02-05', '4个月', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#002', '梁大海', '女', '13198324242', '已婚已育', '潮州', '');
INSERT INTO `migrant` VALUES (27, 'test -', '440485878787878787', '2023-03-27', '4个月', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#002', '梁大海', '女', '18765656565', '单身未育', '中国上海', '');
INSERT INTO `migrant` VALUES (28, '小梁', '440114200893859333', '2023-05-02', '4个月', '租约中', '法仔庄', '01', '工作人员1号', 'staff@01', 'landlord#002', '梁大海', '男', '13875558244', '单身未育', '中国香港', '');
INSERT INTO `migrant` VALUES (29, 't0', '440112989843566545', '2023-02-05', '4个月', '租约中', '矜用庄', '11', '工作人员2号', 'staff@02', 'landlord#102', '梁瞌睡', '男', '13198324242', '已婚未育', '香港', '');
INSERT INTO `migrant` VALUES (30, 'test -', '440485878787878787', '2023-03-27', '4个月', '租约中', '矜用庄', '11', '工作人员2号', 'staff@02', 'landlord#102', '梁瞌睡', '男', '18765656565', '已婚已育', '广东广州', '');
INSERT INTO `migrant` VALUES (31, '罗杰夫', '440121200001010422', '2023-02-15', '半年', '租约中', '矜用庄', '11', '工作人员2号', 'staff@02', 'landlord#102', '梁瞌睡', '女', '13764487294', '单身已育', '上海', '');
INSERT INTO `migrant` VALUES (32, 'tt', '440121989898989898', '2022-05-07', '一年', '租约中', '矜用庄', '11', '工作人员2号', 'staff@02', 'landlord#103', '梁伟文', '女', '13298989898', '已婚未育', '广州', '');

-- ----------------------------
-- Table structure for rent_landlord#001
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#001`;
CREATE TABLE `rent_landlord#001`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#001
-- ----------------------------
INSERT INTO `rent_landlord#001` VALUES (16, '1月', '27', '租约结束', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1728.00', '1728', '1500', '82.00', '81.00', '15', '50', '4', '1.5', '20.5', '54', NULL);
INSERT INTO `rent_landlord#001` VALUES (18, '2月', '27', '租约结束', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#001` VALUES (19, '3月', '29', '租约结束', '503', '440121121212121212', 'test - wholeRent', '每月12号', '√', '已收', '839.60', '840', '650', '32.40', '87.20', '20', '50', '4', '1', '8.1', '87.2', NULL);
INSERT INTO `rent_landlord#001` VALUES (20, '4月', '27', '租约结束', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1669.30', '1669.30', '1500', '36.80', '67.50', '15', '50', '4', '1.5', '9.2', '45', '');
INSERT INTO `rent_landlord#001` VALUES (22, '3月', '27', '租约结束', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1678.50', '1678.50', '1500', '40.00', '73.50', '15', '50', '4', '1.5', '10', '49', '');
INSERT INTO `rent_landlord#001` VALUES (23, '3月', '31', '租约中', '602', '421565656565656565', 't tenant1', '每月30号', '√', '未收', '670.00', '', '600', '0.00', '0.00', '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (24, '6月', '32', '租约结束', '603', '440198444444444444', 't tenant2', '每月30号', '√', '已收', '920.00', '920', '850', '0.00', '0.00', '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (26, '10月', '34', '租约结束', '403', '440121989898989898', 'test t', '每月 1号', '√', '未收', '1175.00', '', '1100', '0.00', '0.00', '25', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '未收', '720.00', '', '650', '0.00', '0.00', '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (28, '1月', '36', '租约结束', '504', '440343434343434343', 't', '每月9号', '√', '未收', '670.00', '', '600', '0.00', '0.00', '20', '50', '5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (29, '2月', '37', '租约中', '603', '440112989843566545', 't0', '每月5号', '√', '未收', '1124.35', '', '850', '93.60', '105.75', '25', '50', '4.5', '1.5', '20.8', '70.5', NULL);
INSERT INTO `rent_landlord#001` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#001` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '√', '未收', '770.00', '', '700', '0.00', '0.00', '20', '50', '4.5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (34, '4月', '40', '租约结束', '504', '440221787875757575', '梁超妍', '每月30号', '√', '未收', '602.00', '', '600', '0.00', '0.00', '1', '1', '1', '1', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (36, '4月', '42', '租约中', '501', '440235445434311342', 'test 8', '每月30号', '√', '未收', '1070.00', '', '1000', '0.00', '0.00', '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (37, '2月', '43', '租约中', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#001` VALUES (38, '2月', '44', '租约中', '606', '440121200001010422', '罗杰夫', '每月15号', '√', '未收', '970.00', '', '900', '0.00', '0.00', '30', '40', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#001` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '720.00', '720.00', '650', '0.00', '0.00', '20', '50', '4', '2', '0', '0', '');
INSERT INTO `rent_landlord#001` VALUES (40, '11月', '45', '租约中', '404', '440114200109270429', '陈奕迅', '每月2号', '待完善', '未收', NULL, NULL, '650', NULL, NULL, '30', '50', '4', '2', '0', '0', NULL);

-- ----------------------------
-- Table structure for rent_landlord#002
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#002`;
CREATE TABLE `rent_landlord#002`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#002
-- ----------------------------
INSERT INTO `rent_landlord#002` VALUES (18, '2月', '27', '租约结束', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#002` VALUES (24, '6月', '32', '租约结束', '603', '440198444444444444', 't tenant2', '每月30号', '√', '已收', '920.00', '920', '850', '0.00', '0.00', '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#002` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '820.00', '820.00', '650', '40.00', '60.00', '20', '50', '4', '2', '10', '30', NULL);
INSERT INTO `rent_landlord#002` VALUES (29, '2月', '37', '租约中', '603', '440112989843566545', 't0', '每月5号', '√', '未收', '1124.35', '', '850', '93.60', '105.75', '25', '50', '4.5', '1.5', '20.8', '70.5', NULL);
INSERT INTO `rent_landlord#002` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#002` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '待完善', '未收', NULL, NULL, '700', NULL, NULL, '20', '50', '4.5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#002` VALUES (34, '4月', '40', '租约结束', '504', '440221787875757575', '梁超妍', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '1', '1', '1', '1', '0', '0', NULL);
INSERT INTO `rent_landlord#002` VALUES (36, '4月', '42', '租约中', '501', '440235445434311342', 'test 8', '每月30号', '待完善', '未收', NULL, NULL, '1000', NULL, NULL, '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#002` VALUES (37, '2月', '43', '租约结束', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#002` VALUES (38, '2月', '44', '租约中', '606', '440121200001010422', '罗杰夫', '每月15号', '待完善', '未收', NULL, NULL, '900', NULL, NULL, '30', '40', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#002` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '720.00', '720.00', '650', '0.00', '0.00', '20', '50', '4', '2', '0', '0', '');
INSERT INTO `rent_landlord#002` VALUES (40, '3月', '45', '租约中', '401', '440114200304938213', '孙尚香', '每月 8号', '√', '未收', '1860.00', '', '1500', '120.00', '180.00', '20', '40', '4', '2', '30', '90', NULL);
INSERT INTO `rent_landlord#002` VALUES (41, '5月', '46', '租约中', '404', '440114200893859333', '小梁', '每月3号', '待完善', '未收', NULL, NULL, '650', NULL, NULL, '40', '30', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#002` VALUES (42, '4月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '未收', '786.00', '', '650', '44.00', '22.00', '20', '50', '4', '2', '11', '11', '');
INSERT INTO `rent_landlord#002` VALUES (43, '4月', '47', '租约结束', 'test', '449114939393939393', '小罗', 'test', '待完善', '未收', NULL, NULL, 'test', NULL, NULL, '20', '50', '4', '1', '0', '0', NULL);

-- ----------------------------
-- Table structure for rent_landlord#003
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#003`;
CREATE TABLE `rent_landlord#003`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#003
-- ----------------------------
INSERT INTO `rent_landlord#003` VALUES (16, '1月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1728.00', '1728', '1500', '82.00', '81.00', '15', '50', '4', '1.5', '20.5', '54', NULL);
INSERT INTO `rent_landlord#003` VALUES (18, '2月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#003` VALUES (19, '3月', '29', '租约结束', '503', '440121121212121212', 'test - wholeRent', '每月12号', '√', '已收', '839.60', '840', '650', '32.40', '87.20', '20', '50', '4', '1', '8.1', '87.2', NULL);
INSERT INTO `rent_landlord#003` VALUES (20, '4月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1669.30', '1669.30', '1500', '36.80', '67.50', '15', '50', '4', '1.5', '9.2', '45', '');
INSERT INTO `rent_landlord#003` VALUES (22, '3月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1678.50', '1678.50', '1500', '40.00', '73.50', '15', '50', '4', '1.5', '10', '49', '');
INSERT INTO `rent_landlord#003` VALUES (23, '3月', '31', '租约中', '602', '421565656565656565', 't tenant1', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (24, '6月', '32', '租约结束', '603', '440198444444444444', 't tenant2', '每月30号', '√', '已收', '920.00', '920', '850', '0.00', '0.00', '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (26, '10月', '34', '租约结束', '403', '440121989898989898', 'test t', '每月 1号', '待完善', '未收', NULL, NULL, '1100', NULL, NULL, '25', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '待完善', '未收', NULL, NULL, '650', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (28, '1月', '36', '租约结束', '504', '440343434343434343', 't', '每月9号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (29, '2月', '37', '租约中', '603', '440112989843566545', 't0', '每月5号', '√', '未收', '1124.35', '', '850', '93.60', '105.75', '25', '50', '4.5', '1.5', '20.8', '70.5', NULL);
INSERT INTO `rent_landlord#003` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#003` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '待完善', '未收', NULL, NULL, '700', NULL, NULL, '20', '50', '4.5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (34, '4月', '40', '租约结束', '504', '440221787875757575', '梁超妍', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '1', '1', '1', '1', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (36, '4月', '42', '租约中', '501', '440235445434311342', 'test 8', '每月30号', '待完善', '未收', NULL, NULL, '1000', NULL, NULL, '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (37, '2月', '43', '租约中', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#003` VALUES (38, '2月', '44', '租约中', '606', '440121200001010422', '罗杰夫', '每月15号', '待完善', '未收', NULL, NULL, '900', NULL, NULL, '30', '40', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#003` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '720.00', '720.00', '650', '0.00', '0.00', '20', '50', '4', '2', '0', '0', '');

-- ----------------------------
-- Table structure for rent_landlord#004
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#004`;
CREATE TABLE `rent_landlord#004`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#004
-- ----------------------------
INSERT INTO `rent_landlord#004` VALUES (16, '1月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1728.00', '1728', '1500', '82.00', '81.00', '15', '50', '4', '1.5', '20.5', '54', NULL);
INSERT INTO `rent_landlord#004` VALUES (18, '2月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#004` VALUES (19, '3月', '29', '租约结束', '503', '440121121212121212', 'test - wholeRent', '每月12号', '√', '已收', '839.60', '840', '650', '32.40', '87.20', '20', '50', '4', '1', '8.1', '87.2', NULL);
INSERT INTO `rent_landlord#004` VALUES (20, '4月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1669.30', '1669.30', '1500', '36.80', '67.50', '15', '50', '4', '1.5', '9.2', '45', '');
INSERT INTO `rent_landlord#004` VALUES (22, '3月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1678.50', '1678.50', '1500', '40.00', '73.50', '15', '50', '4', '1.5', '10', '49', '');
INSERT INTO `rent_landlord#004` VALUES (23, '3月', '31', '租约中', '602', '421565656565656565', 't tenant1', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (24, '6月', '32', '租约结束', '603', '440198444444444444', 't tenant2', '每月30号', '√', '已收', '920.00', '920', '850', '0.00', '0.00', '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (26, '10月', '34', '租约结束', '403', '440121989898989898', 'test t', '每月 1号', '待完善', '未收', NULL, NULL, '1100', NULL, NULL, '25', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '1040.00', '1040.00', '650', '120.00', '200.00', '20', '50', '4', '2', '30', '100', NULL);
INSERT INTO `rent_landlord#004` VALUES (28, '1月', '36', '租约结束', '504', '440343434343434343', 't', '每月9号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (29, '2月', '37', '租约中', '603', '440112989843566545', 't0', '每月5号', '√', '未收', '1124.35', '', '850', '93.60', '105.75', '25', '50', '4.5', '1.5', '20.8', '70.5', NULL);
INSERT INTO `rent_landlord#004` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#004` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '待完善', '未收', NULL, NULL, '700', NULL, NULL, '20', '50', '4.5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (34, '4月', '40', '租约结束', '504', '440221787875757575', '梁超妍', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '1', '1', '1', '1', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (36, '4月', '42', '租约中', '501', '440235445434311342', 'test 8', '每月30号', '待完善', '未收', NULL, NULL, '1000', NULL, NULL, '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (37, '2月', '43', '租约中', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#004` VALUES (38, '2月', '44', '租约中', '606', '440121200001010422', '罗杰夫', '每月15号', '待完善', '未收', NULL, NULL, '900', NULL, NULL, '30', '40', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#004` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '720.00', '720.00', '650', '0.00', '0.00', '20', '50', '4', '2', '0', '0', '');

-- ----------------------------
-- Table structure for rent_landlord#101
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#101`;
CREATE TABLE `rent_landlord#101`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#101
-- ----------------------------
INSERT INTO `rent_landlord#101` VALUES (16, '1月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1728.00', '1728', '1500', '82.00', '81.00', '15', '50', '4', '1.5', '20.5', '54', NULL);
INSERT INTO `rent_landlord#101` VALUES (18, '2月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#101` VALUES (19, '3月', '29', '租约结束', '503', '440121121212121212', 'test - wholeRent', '每月12号', '√', '已收', '839.60', '840', '650', '32.40', '87.20', '20', '50', '4', '1', '8.1', '87.2', NULL);
INSERT INTO `rent_landlord#101` VALUES (20, '4月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1669.30', '1669.30', '1500', '36.80', '67.50', '15', '50', '4', '1.5', '9.2', '45', '');
INSERT INTO `rent_landlord#101` VALUES (22, '3月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1678.50', '1678.50', '1500', '40.00', '73.50', '15', '50', '4', '1.5', '10', '49', '');
INSERT INTO `rent_landlord#101` VALUES (23, '3月', '31', '租约中', '602', '421565656565656565', 't tenant1', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#101` VALUES (24, '6月', '32', '租约结束', '603', '440198444444444444', 't tenant2', '每月30号', '√', '已收', '920.00', '920', '850', '0.00', '0.00', '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#101` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '待完善', '未收', NULL, NULL, '650', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#101` VALUES (29, '2月', '37', '租约中', '603', '440112989843566545', 't0', '每月5号', '√', '未收', '1124.35', '', '850', '93.60', '105.75', '25', '50', '4.5', '1.5', '20.8', '70.5', NULL);
INSERT INTO `rent_landlord#101` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#101` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '√', '未收', '872.75', '', '700', '42.75', '60.00', '20', '50', '4.5', '2', '9.5', '30', NULL);
INSERT INTO `rent_landlord#101` VALUES (36, '4月', '42', '租约结束', '501', '440235445434311342', 'test 8', '每月30号', '待完善', '未收', NULL, NULL, '1000', NULL, NULL, '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#101` VALUES (37, '2月', '43', '租约中', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#101` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '720.00', '720.00', '650', '0.00', '0.00', '20', '50', '4', '2', '0', '0', '');
INSERT INTO `rent_landlord#101` VALUES (40, '1月', '45', '租约中', '502', '440114200109270429', '田柾国', '每月15号', '√', '已收', '1170.55', '1170.55', '900', '34.80', '165.75', '20', '50', '4', '1.5', '8.7', '110.5', NULL);

-- ----------------------------
-- Table structure for rent_landlord#102
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#102`;
CREATE TABLE `rent_landlord#102`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#102
-- ----------------------------
INSERT INTO `rent_landlord#102` VALUES (16, '1月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1728.00', '1728', '1500', '82.00', '81.00', '15', '50', '4', '1.5', '20.5', '54', NULL);
INSERT INTO `rent_landlord#102` VALUES (18, '2月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#102` VALUES (20, '4月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1669.30', '1669.30', '1500', '36.80', '67.50', '15', '50', '4', '1.5', '9.2', '45', '');
INSERT INTO `rent_landlord#102` VALUES (22, '3月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1678.50', '1678.50', '1500', '40.00', '73.50', '15', '50', '4', '1.5', '10', '49', '');
INSERT INTO `rent_landlord#102` VALUES (23, '3月', '31', '租约中', '602', '421565656565656565', 't tenant1', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#102` VALUES (24, '6月', '32', '租约结束', '603', '440198444444444444', 't tenant2', '每月30号', '√', '已收', '920.00', '920', '850', '0.00', '0.00', '20', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#102` VALUES (26, '10月', '34', '租约结束', '403', '440121989898989898', 'test t', '每月 1号', '待完善', '未收', NULL, NULL, '1100', NULL, NULL, '25', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#102` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '待完善', '未收', NULL, NULL, '650', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#102` VALUES (28, '1月', '36', '租约结束', '504', '440343434343434343', 't', '每月9号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#102` VALUES (29, '2月', '37', '租约结束', '603', '440112989843566545', 't0', '每月5号', '√', '未收', '1124.35', '', '850', '93.60', '105.75', '25', '50', '4.5', '1.5', '20.8', '70.5', NULL);
INSERT INTO `rent_landlord#102` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#102` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '待完善', '未收', NULL, NULL, '700', NULL, NULL, '20', '50', '4.5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#102` VALUES (36, '4月', '42', '租约中', '501', '440235445434311342', 'test 8', '每月30号', '√', '已收', '1270.00', '1270.00', '1000', '80.00', '120.00', '20', '50', '4', '1.5', '20', '80', NULL);
INSERT INTO `rent_landlord#102` VALUES (37, '2月', '43', '租约中', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#102` VALUES (38, '2月', '44', '租约中', '606', '440121200001010422', '罗杰夫', '每月15号', '待完善', '未收', NULL, NULL, '900', NULL, NULL, '30', '40', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#102` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '980.00', '720.00', '650', '200.00', '60.00', '20', '50', '4', '2', '50', '30', '');
INSERT INTO `rent_landlord#102` VALUES (40, '4月', '37', '租约结束', '603', '440112989843566545', 't0', '每月5号', '√', '未收', '1127.35', '', '850', '90.45', '111.90', '25', '50', '4.5', '1.5', '20.1', '74.6', '');
INSERT INTO `rent_landlord#102` VALUES (41, '4月', '45', '租约结束', '401', '440114120492059305', 'test last', '每月1号', '待完善', '未收', NULL, NULL, '1500', NULL, NULL, '20', '50', '5', '2', '0', '0', NULL);

-- ----------------------------
-- Table structure for rent_landlord#103
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#103`;
CREATE TABLE `rent_landlord#103`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#103
-- ----------------------------
INSERT INTO `rent_landlord#103` VALUES (16, '1月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1728.00', '1728', '1500', '82.00', '81.00', '15', '50', '4', '1.5', '20.5', '54', NULL);
INSERT INTO `rent_landlord#103` VALUES (18, '2月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#103` VALUES (20, '4月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1669.30', '1669.30', '1500', '36.80', '67.50', '15', '50', '4', '1.5', '9.2', '45', '');
INSERT INTO `rent_landlord#103` VALUES (22, '3月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1678.50', '1678.50', '1500', '40.00', '73.50', '15', '50', '4', '1.5', '10', '49', '');
INSERT INTO `rent_landlord#103` VALUES (23, '3月', '31', '租约中', '602', '421565656565656565', 't tenant1', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#103` VALUES (26, '10月', '34', '租约结束', '403', '440121989898989898', 'test t', '每月 1号', '待完善', '未收', NULL, NULL, '1100', NULL, NULL, '25', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#103` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '待完善', '未收', NULL, NULL, '650', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#103` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#103` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '√', '已收', '3485.00', '3485.00', '700', '495.00', '2220.00', '20', '50', '4.5', '2', '110', '1110', NULL);
INSERT INTO `rent_landlord#103` VALUES (36, '4月', '42', '租约中', '501', '440235445434311342', 'test 8', '每月30号', '√', '已收', '1270.00', '1270.00', '1000', '80.00', '120.00', '20', '50', '4', '1.5', '20', '80', NULL);
INSERT INTO `rent_landlord#103` VALUES (37, '2月', '43', '租约中', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#103` VALUES (38, '2月', '44', '租约中', '606', '440121200001010422', '罗杰夫', '每月15号', '待完善', '未收', NULL, NULL, '900', NULL, NULL, '30', '40', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#103` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '980.00', '720.00', '650', '200.00', '60.00', '20', '50', '4', '2', '50', '30', '');
INSERT INTO `rent_landlord#103` VALUES (41, '4月', '45', '租约结束', '401', '440114120492059305', 'test last', '每月1号', '待完善', '未收', NULL, NULL, '1500', NULL, NULL, '20', '50', '5', '2', '0', '0', NULL);

-- ----------------------------
-- Table structure for rent_landlord#104
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#104`;
CREATE TABLE `rent_landlord#104`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#104
-- ----------------------------
INSERT INTO `rent_landlord#104` VALUES (16, '1月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1728.00', '1728', '1500', '82.00', '81.00', '15', '50', '4', '1.5', '20.5', '54', NULL);
INSERT INTO `rent_landlord#104` VALUES (18, '2月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1692.50', '1692.5', '1500', '120.00', '7.50', '15', '50', '4', '1.5', '30', '5', '');
INSERT INTO `rent_landlord#104` VALUES (20, '4月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1669.30', '1669.30', '1500', '36.80', '67.50', '15', '50', '4', '1.5', '9.2', '45', '');
INSERT INTO `rent_landlord#104` VALUES (22, '3月', '27', '租约中', '402', '440123123123123123', 'test - duplicate TenantID', '每月21号', '√', '已收', '1678.50', '1678.50', '1500', '40.00', '73.50', '15', '50', '4', '1.5', '10', '49', '');
INSERT INTO `rent_landlord#104` VALUES (23, '3月', '31', '租约中', '602', '421565656565656565', 't tenant1', '每月30号', '待完善', '未收', NULL, NULL, '600', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#104` VALUES (26, '10月', '34', '租约结束', '403', '440121989898989898', 'test t', '每月 1号', '待完善', '未收', NULL, NULL, '1100', NULL, NULL, '25', '50', '4', '1.5', '0', '0', NULL);
INSERT INTO `rent_landlord#104` VALUES (27, '5月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '待完善', '未收', NULL, NULL, '650', NULL, NULL, '20', '50', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#104` VALUES (31, '3月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '886.80', '886.80', '650', '34.00', '132.80', '20', '50', '4', '2', '8.5', '66.4', '');
INSERT INTO `rent_landlord#104` VALUES (32, '3月', '38', '租约中', '505', '440485878787878787', 'test -', '每月30号', '待完善', '未收', NULL, NULL, '700', NULL, NULL, '20', '50', '4.5', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#104` VALUES (36, '4月', '42', '租约中', '501', '440235445434311342', 'test 8', '每月30号', '√', '已收', '1270.00', '1270.00', '1000', '80.00', '120.00', '20', '50', '4', '1.5', '20', '80', NULL);
INSERT INTO `rent_landlord#104` VALUES (37, '2月', '43', '租约中', '403', '440121200109270429', '梁超妍', '每月12号', '√', '未收', '1357.70', '', '1100', '47.70', '140.00', '20', '50', '4.5', '2', '10.6', '70', NULL);
INSERT INTO `rent_landlord#104` VALUES (38, '2月', '44', '租约中', '606', '440121200001010422', '罗杰夫', '每月15号', '待完善', '未收', NULL, NULL, '900', NULL, NULL, '30', '40', '4', '2', '0', '0', NULL);
INSERT INTO `rent_landlord#104` VALUES (39, '2月', '35', '租约中', '601', '440121989898989898', 'tt', '每月 3号', '√', '已收', '980.00', '720.00', '650', '200.00', '60.00', '20', '50', '4', '2', '50', '30', '');
INSERT INTO `rent_landlord#104` VALUES (41, '4月', '45', '租约结束', '401', '440114120492059305', 'test last', '每月1号', '待完善', '未收', NULL, NULL, '1500', NULL, NULL, '20', '50', '5', '2', '0', '0', NULL);

-- ----------------------------
-- Table structure for rent_landlord#105
-- ----------------------------
DROP TABLE IF EXISTS `rent_landlord#105`;
CREATE TABLE `rent_landlord#105`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Month` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '月份',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '房号',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CollectionDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收租日',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '待完善，√',
  `Stage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已收，未收',
  `ToalAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合计应收',
  `ActualAmount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MonthlyRent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '月租',
  `WaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水费',
  `ElectricityFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电费',
  `HygieneFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NetworkFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitWaterFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位水费',
  `UnitElectrictyFee` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位电费',
  `WaterMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '水表吨数',
  `ElectricityMeterDegree` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电表度数',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_landlord#105
-- ----------------------------

-- ----------------------------
-- Table structure for room_landlord#001
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#001`;
CREATE TABLE `room_landlord#001`  (
  `No` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#001
-- ----------------------------
INSERT INTO `room_landlord#001` VALUES (0000000003, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#001` VALUES (0000000019, '403', '一房一厅', '1100', '2200', '两押一租', '配置齐全', '50', '半年', '已出租', '43', '梁超妍', '440121200109270429', '');
INSERT INTO `room_landlord#001` VALUES (0000000020, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#001` VALUES (0000000021, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '已出租', '42', 'test 8', '440235445434311342', '');
INSERT INTO `room_landlord#001` VALUES (0000000022, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '已出租', '31', 't tenant1', '421565656565656565', '');
INSERT INTO `room_landlord#001` VALUES (0000000023, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#001` VALUES (0000000024, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#001` VALUES (0000000025, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#001` VALUES (0000000029, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '已出租', '37', 't0', '440112989843566545', '');
INSERT INTO `room_landlord#001` VALUES (0000000030, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#001` VALUES (0000000031, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '已出租', '45', '陈奕迅', '440114200109270429', '');
INSERT INTO `room_landlord#001` VALUES (0000000032, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '已出租', '44', '罗杰夫', '440121200001010422', '');

-- ----------------------------
-- Table structure for room_landlord#002
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#002`;
CREATE TABLE `room_landlord#002`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#002
-- ----------------------------
INSERT INTO `room_landlord#002` VALUES (3, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '已出租', '45', '孙尚香', '440114200304938213', '');
INSERT INTO `room_landlord#002` VALUES (20, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#002` VALUES (21, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '已出租', '42', 'test 8', '440235445434311342', '');
INSERT INTO `room_landlord#002` VALUES (22, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#002` VALUES (23, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#002` VALUES (24, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#002` VALUES (25, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#002` VALUES (29, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '已出租', '37', 't0', '440112989843566545', '');
INSERT INTO `room_landlord#002` VALUES (30, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#002` VALUES (31, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '已出租', '46', '小梁', '440114200893859333', '');
INSERT INTO `room_landlord#002` VALUES (32, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '已出租', '44', '罗杰夫', '440121200001010422', '');

-- ----------------------------
-- Table structure for room_landlord#003
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#003`;
CREATE TABLE `room_landlord#003`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#003
-- ----------------------------
INSERT INTO `room_landlord#003` VALUES (3, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#003` VALUES (19, '403', '一房一厅', '1100', '2200', '两押一租', '配置齐全', '50', '半年', '已出租', '43', '梁超妍', '440121200109270429', '');
INSERT INTO `room_landlord#003` VALUES (20, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#003` VALUES (21, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '已出租', '42', 'test 8', '440235445434311342', '');
INSERT INTO `room_landlord#003` VALUES (22, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '已出租', '31', 't tenant1', '421565656565656565', '');
INSERT INTO `room_landlord#003` VALUES (23, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#003` VALUES (24, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '已出租', '27', 'test - duplicate TenantID', '440123123123123123', '');
INSERT INTO `room_landlord#003` VALUES (25, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#003` VALUES (29, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '已出租', '37', 't0', '440112989843566545', '');
INSERT INTO `room_landlord#003` VALUES (30, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#003` VALUES (31, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#003` VALUES (32, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '已出租', '44', '罗杰夫', '440121200001010422', '');

-- ----------------------------
-- Table structure for room_landlord#004
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#004`;
CREATE TABLE `room_landlord#004`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#004
-- ----------------------------
INSERT INTO `room_landlord#004` VALUES (3, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#004` VALUES (19, '403', '一房一厅', '1100', '2200', '两押一租', '配置齐全', '50', '半年', '已出租', '43', '梁超妍', '440121200109270429', '');
INSERT INTO `room_landlord#004` VALUES (20, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#004` VALUES (21, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '已出租', '42', 'test 8', '440235445434311342', '');
INSERT INTO `room_landlord#004` VALUES (22, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '已出租', '31', 't tenant1', '421565656565656565', '');
INSERT INTO `room_landlord#004` VALUES (23, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#004` VALUES (24, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '已出租', '27', 'test - duplicate TenantID', '440123123123123123', '');
INSERT INTO `room_landlord#004` VALUES (25, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#004` VALUES (29, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '已出租', '37', 't0', '440112989843566545', '');
INSERT INTO `room_landlord#004` VALUES (30, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#004` VALUES (31, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#004` VALUES (32, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '已出租', '44', '罗杰夫', '440121200001010422', '');

-- ----------------------------
-- Table structure for room_landlord#101
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#101`;
CREATE TABLE `room_landlord#101`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#101
-- ----------------------------
INSERT INTO `room_landlord#101` VALUES (3, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#101` VALUES (19, '403', '一房一厅', '1100', '2200', '两押一租', '配置齐全', '50', '半年', '已出租', '43', '梁超妍', '440121200109270429', '');
INSERT INTO `room_landlord#101` VALUES (20, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#101` VALUES (21, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#101` VALUES (22, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '已出租', '31', 't tenant1', '421565656565656565', '');
INSERT INTO `room_landlord#101` VALUES (23, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#101` VALUES (24, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '已出租', '27', 'test - duplicate TenantID', '440123123123123123', '');
INSERT INTO `room_landlord#101` VALUES (25, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#101` VALUES (29, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '已出租', '37', 't0', '440112989843566545', '');
INSERT INTO `room_landlord#101` VALUES (30, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#101` VALUES (31, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#101` VALUES (32, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#101` VALUES (33, '502', '一房一厅', '900', '1800', '两押一租', '配置齐全', '30', '半年', '已出租', '45', '田柾国', '440114200109270429', '');

-- ----------------------------
-- Table structure for room_landlord#102
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#102`;
CREATE TABLE `room_landlord#102`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#102
-- ----------------------------
INSERT INTO `room_landlord#102` VALUES (3, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#102` VALUES (19, '403', '一房一厅', '1100', '2200', '两押一租', '配置齐全', '50', '半年', '已出租', '43', '梁超妍', '440121200109270429', '');
INSERT INTO `room_landlord#102` VALUES (20, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#102` VALUES (21, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '已出租', '42', 'test 8', '440235445434311342', '');
INSERT INTO `room_landlord#102` VALUES (22, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '已出租', '31', 't tenant1', '421565656565656565', '');
INSERT INTO `room_landlord#102` VALUES (23, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#102` VALUES (24, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '已出租', '27', 'test - duplicate TenantID', '440123123123123123', '');
INSERT INTO `room_landlord#102` VALUES (25, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#102` VALUES (29, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#102` VALUES (30, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#102` VALUES (31, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#102` VALUES (32, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '已出租', '44', '罗杰夫', '440121200001010422', '');

-- ----------------------------
-- Table structure for room_landlord#103
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#103`;
CREATE TABLE `room_landlord#103`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#103
-- ----------------------------
INSERT INTO `room_landlord#103` VALUES (3, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#103` VALUES (19, '403', '一房一厅', '1100', '2200', '两押一租', '配置齐全', '50', '半年', '已出租', '43', '梁超妍', '440121200109270429', '');
INSERT INTO `room_landlord#103` VALUES (20, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#103` VALUES (21, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '已出租', '42', 'test 8', '440235445434311342', '');
INSERT INTO `room_landlord#103` VALUES (22, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '已出租', '31', 't tenant1', '421565656565656565', '');
INSERT INTO `room_landlord#103` VALUES (23, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#103` VALUES (24, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '已出租', '27', 'test - duplicate TenantID', '440123123123123123', '');
INSERT INTO `room_landlord#103` VALUES (25, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#103` VALUES (29, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#103` VALUES (30, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#103` VALUES (31, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#103` VALUES (32, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '已出租', '44', '罗杰夫', '440121200001010422', '');

-- ----------------------------
-- Table structure for room_landlord#104
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#104`;
CREATE TABLE `room_landlord#104`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#104
-- ----------------------------
INSERT INTO `room_landlord#104` VALUES (3, '401', '两房一厅', '1500', '4500', '三押一租', '配置齐全', '65', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#104` VALUES (19, '403', '一房一厅', '1100', '2200', '两押一租', '配置齐全', '50', '半年', '已出租', '43', '梁超妍', '440121200109270429', '');
INSERT INTO `room_landlord#104` VALUES (20, '504', '单间', '600', '1200', '两押一租', '有缺', '25', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#104` VALUES (21, '501', '一房一厅', '1000', '2000', '两押一租', '有缺', '45', '半年', '已出租', '42', 'test 8', '440235445434311342', '');
INSERT INTO `room_landlord#104` VALUES (22, '602', '单间', '600', '1200', '两押一租', '配置齐全', '30', '半年', '已出租', '31', 't tenant1', '421565656565656565', '');
INSERT INTO `room_landlord#104` VALUES (23, '601', '单间', '650', '1300', '两押一租', '配置齐全', '30', '3个月', '已出租', '35', 'tt', '440121989898989898', '');
INSERT INTO `room_landlord#104` VALUES (24, '402', '两房一厅', '1500', '4500', '三押一租', '有缺', '65', '半年', '已出租', '27', 'test - duplicate TenantID', '440123123123123123', '');
INSERT INTO `room_landlord#104` VALUES (25, '503', '单间', '650', '1300', '两押一租', '配置齐全', '20', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#104` VALUES (29, '603', '一房一厅', '850', '1700', '两押一租', '有缺', '45', '半年', '未出租', '', '', '', '');
INSERT INTO `room_landlord#104` VALUES (30, '505', '单间', '700', '1400', '两押一租 ', '配置齐全', '20', '三个月', '已出租', '38', 'test -', '440485878787878787', '');
INSERT INTO `room_landlord#104` VALUES (31, '404', '单间', '650', '1300', '两押一租 ', '配置齐全', '20', '3个月', '未出租', '', '', '', '');
INSERT INTO `room_landlord#104` VALUES (32, '606', '一房一厅', '900', '1800', '两押一租', '有缺', '35', '4个月', '已出租', '44', '罗杰夫', '440121200001010422', '');

-- ----------------------------
-- Table structure for room_landlord#105
-- ----------------------------
DROP TABLE IF EXISTS `room_landlord#105`;
CREATE TABLE `room_landlord#105`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `RoomType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Rent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租金',
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsFurnished` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置：齐全、有缺',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `MinimunPeriod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租时长',
  `RentStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出租状态',
  `ContractNo` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `TenantName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `TenantIDCard` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '租客身份证',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_landlord#105
-- ----------------------------

-- ----------------------------
-- Table structure for roomtype_landlord#001
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#001`;
CREATE TABLE `roomtype_landlord#001`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#001
-- ----------------------------
INSERT INTO `roomtype_landlord#001` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/543.jpeg', '25', '600 起', '1200', '两押一租 ', 2);
INSERT INTO `roomtype_landlord#001` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/%E8%BD%BD.jpg', '70', '2500 起', '5000', '三押一租', 2);
INSERT INTO `roomtype_landlord#001` VALUES (3, '一房一厅', 4, '单人床，空调，热水器，茶几，沙发，衣柜', '403,501,603,606', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/fds.jpeg', '45', '850 起', '1500', '两押一租', 0);

-- ----------------------------
-- Table structure for roomtype_landlord#002
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#002`;
CREATE TABLE `roomtype_landlord#002`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#002
-- ----------------------------
INSERT INTO `roomtype_landlord#002` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/6534.jpg', '25', '600 起', '1200', '两押一租 ', 3);
INSERT INTO `roomtype_landlord#002` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '70', '2500 起', '5000', '三押一租', 1);
INSERT INTO `roomtype_landlord#002` VALUES (3, '一房一厅', 3, '单人床，空调，热水器，茶几，沙发，衣柜', '501,603,606', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '45', '850 起', '1500', '两押一租', 0);

-- ----------------------------
-- Table structure for roomtype_landlord#003
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#003`;
CREATE TABLE `roomtype_landlord#003`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#003
-- ----------------------------
INSERT INTO `roomtype_landlord#003` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '25', '600 起', '1200', '两押一租 ', 3);
INSERT INTO `roomtype_landlord#003` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '70', '2500 起', '5000', '三押一租', 1);
INSERT INTO `roomtype_landlord#003` VALUES (3, '一房一厅', 4, '单人床，空调，热水器，茶几，沙发，衣柜', '403,501,603,606', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/7868.png', '45', '850 起', '1500', '两押一租', 0);
INSERT INTO `roomtype_landlord#003` VALUES (6, 'test', 0, '齐全', '', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/534.jpeg', '30', '1000', '', '两押一租', 0);

-- ----------------------------
-- Table structure for roomtype_landlord#004
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#004`;
CREATE TABLE `roomtype_landlord#004`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#004
-- ----------------------------
INSERT INTO `roomtype_landlord#004` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '25', '600 起', '1200', '两押一租 ', 3);
INSERT INTO `roomtype_landlord#004` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '70', '2500 起', '5000', '三押一租', 1);
INSERT INTO `roomtype_landlord#004` VALUES (3, '一房一厅', 4, '单人床，空调，热水器，茶几，沙发，衣柜', '403,501,603,606', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/7868.png', '45', '850 起', '1500', '两押一租', 0);

-- ----------------------------
-- Table structure for roomtype_landlord#101
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#101`;
CREATE TABLE `roomtype_landlord#101`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#101
-- ----------------------------
INSERT INTO `roomtype_landlord#101` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '25', '600 起', '1200', '两押一租 ', 3);
INSERT INTO `roomtype_landlord#101` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '70', '2500 起', '5000', '三押一租', 1);
INSERT INTO `roomtype_landlord#101` VALUES (3, '一房一厅', 5, '单人床，空调，热水器，茶几，沙发，衣柜', '403,501,603,606,502', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '45', '850 起', '1500', '两押一租', 2);

-- ----------------------------
-- Table structure for roomtype_landlord#102
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#102`;
CREATE TABLE `roomtype_landlord#102`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#102
-- ----------------------------
INSERT INTO `roomtype_landlord#102` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/432.jpeg', '25', '600 起', '1200', '两押一租 ', 3);
INSERT INTO `roomtype_landlord#102` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '70', '2500 起', '5000', '三押一租', 1);
INSERT INTO `roomtype_landlord#102` VALUES (3, '一房一厅', 4, '单人床，空调，热水器，茶几，沙发，衣柜', '403,501,603,606', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '45', '850 起', '1500', '两押一租', 1);

-- ----------------------------
-- Table structure for roomtype_landlord#103
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#103`;
CREATE TABLE `roomtype_landlord#103`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#103
-- ----------------------------
INSERT INTO `roomtype_landlord#103` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/7868.png', '25', '600 起', '1200', '两押一租 ', 3);
INSERT INTO `roomtype_landlord#103` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '70', '2500 起', '5000', '三押一租', 0);
INSERT INTO `roomtype_landlord#103` VALUES (3, '一房一厅', 4, '单人床，空调，热水器，茶几，沙发，衣柜', '403,501,603,606', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '45', '850 起', '1500', '两押一租', 0);

-- ----------------------------
-- Table structure for roomtype_landlord#104
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#104`;
CREATE TABLE `roomtype_landlord#104`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#104
-- ----------------------------
INSERT INTO `roomtype_landlord#104` VALUES (1, '单间', 6, '单人床，书桌，热水器，衣柜，空调', '505,602,601,503,504,404', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/432.jpeg', '25', '600 起', '1200', '两押一租 ', 3);
INSERT INTO `roomtype_landlord#104` VALUES (2, '两房一厅', 2, '茶几，沙发，双人床，单人床，衣柜，空调，热水器，电视机 ，洗衣机，抽油烟机', '401,402', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '70', '2500 起', '5000', '三押一租', 0);
INSERT INTO `roomtype_landlord#104` VALUES (3, '一房一厅', 4, '单人床，空调，热水器，茶几，沙发，衣柜', '403,501,603,606', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', '45', '850 起', '1500', '两押一租', 0);

-- ----------------------------
-- Table structure for roomtype_landlord#105
-- ----------------------------
DROP TABLE IF EXISTS `roomtype_landlord#105`;
CREATE TABLE `roomtype_landlord#105`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型',
  `Amount` int NOT NULL COMMENT '总数量',
  `Furnishment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置Set',
  `RoomNumber` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号，可以没有',
  `Picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房型图，用于网站显示',
  `Square` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MortgageCash` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '押金',
  `MortgageMethod` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '按押方式',
  `AvailableRoomsQuantity` int NULL DEFAULT NULL COMMENT '未出租的房间数量',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype_landlord#105
-- ----------------------------

-- ----------------------------
-- Table structure for staff@01_inspectation
-- ----------------------------
DROP TABLE IF EXISTS `staff@01_inspectation`;
CREATE TABLE `staff@01_inspectation`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Area` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HouseNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Owner` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '屋主',
  `Time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '巡查时间',
  `StaffName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员姓名',
  `Staff_ID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员ID',
  `Overall` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '总体巡查情况（合格、不合格）',
  `EntranceGuard` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '门禁安装：有、无',
  `ServeillanceSystem` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '监控系统',
  `FireSafety` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '消防安全：合格、存在隐患',
  `Sanitry` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '卫生条件：合格、需要整理',
  `Structural` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '结构安全：合格、存在隐患',
  `Circuit` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电路安全：合格、存在隐患',
  `Other` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '其他：合格、存在隐患',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FailReason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE,
  INDEX `Name`(`Title`) USING BTREE,
  INDEX `Inspectation_staff`(`Staff_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff@01_inspectation
-- ----------------------------
INSERT INTO `staff@01_inspectation` VALUES (2, '2月', '法仔庄', '七巷1号', '梁爷爷', '2023-02-26', '工作人员1号', 'staff@01', '合格', '已安装', '已安装', '合格', '合格', '合格', '合格', '过关', '有装修计划', '');
INSERT INTO `staff@01_inspectation` VALUES (3, '3月', '法仔庄', '七巷1号', '梁爷爷', '2023-03-01', '工作人员1号', 'staff@01', '合格', '已安装', '已安装', '合格', '合格', '合格', '合格', '', '', '');
INSERT INTO `staff@01_inspectation` VALUES (5, '年前消防检查', '法仔庄', '七巷1号', '梁爷爷', '2023-01-10', '工作人员1号', 'staff@01', '合格', '已安装', '已安装', '合格', '合格', '合格', '合格', '没问题', '', '');
INSERT INTO `staff@01_inspectation` VALUES (6, '整村电路安全检查', '法仔庄', '七巷1号', '梁爷爷', '2023-01-10', '工作人员1号', 'staff@01', '需整改', '已安装', '已安装', '合格', '合格', '合格', '合格', '', '', '测试');
INSERT INTO `staff@01_inspectation` VALUES (13, '整村电路安全检查', '法仔庄', '五巷3号', '梁超妍', '2023-01-10', '工作人员1号', 'staff@01', '合格', '已安装', '已安装', '合格', '合格', '合格', '合格', '没问题', '', '');
INSERT INTO `staff@01_inspectation` VALUES (19, '整村电路安全检查', '法仔庄', '五巷3号', '梁超妍', '2023-01-10', '工作人员1号', 'staff@01', '需整改', '已安装', '已安装', '合格', '合格', '合格', '合格', '', '', '');
INSERT INTO `staff@01_inspectation` VALUES (21, '3月', '法仔庄', '八巷2号', '梁大海', '2023-03-01', '工作人员1号', 'staff@01', '合格', '已安装', '已安装', '合格', '合格', '合格', '合格', '', '勉强合格', '');
INSERT INTO `staff@01_inspectation` VALUES (23, 'test', '法仔庄', '七巷1号', '梁爷爷', '2023-05-03', '工作人员1号', 'staff@01', '需整改', '未安装', '已安装', '合格', '存在隐患', '存在隐患', '合格', '', '', '测试');

-- ----------------------------
-- Table structure for staff@01_opinion
-- ----------------------------
DROP TABLE IF EXISTS `staff@01_opinion`;
CREATE TABLE `staff@01_opinion`  (
  `No` int(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `Title` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `Category` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '类别：出租屋、服务站管理、活动、其他',
  `Detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '具体',
  `LandlordName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Landlord_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SubmitTime` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '提交意见时间',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '阶段：已上报、接纳、否定',
  `StaffName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Staff_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员ID',
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AreaID` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Response` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '回复',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff@01_opinion
-- ----------------------------
INSERT INTO `staff@01_opinion` VALUES (02, '意见 02', '出租屋', 'try', '梁超妍', 'landlord#003', '2023-03-07', '接纳意见', '工作人员1号', 'staff@01', '法仔庄', '01', '很好');
INSERT INTO `staff@01_opinion` VALUES (07, '意见 07', '检查', '无啊', '梁超妍', 'landlord#003', '2023-03-03', '接纳意见', '工作人员1号', 'staff@01', '法仔庄', '01', '');
INSERT INTO `staff@01_opinion` VALUES (08, '建议开展精神建设活动', '活动', '有利身心健康', '梁大海', 'landlord#002', '2022-10-11', '否决意见', '工作人员1号', 'staff@01', '法仔庄', '01', '否决');
INSERT INTO `staff@01_opinion` VALUES (09, '建议加强不定时巡查', '检查', '多次巡查，更好维护出租屋管理', '梁大海', 'landlord#002', '2023-02-01', '接纳意见', '工作人员1号', 'staff@01', '法仔庄', '01', '');
INSERT INTO `staff@01_opinion` VALUES (10, '管理细化', '出租屋事务', '一个月前提交的意见，至今未得到反馈', '梁大海', 'landlord#002', '2022-11-05', '否决意见', '工作人员1号', 'staff@01', '法仔庄', '01', '');
INSERT INTO `staff@01_opinion` VALUES (11, '加强流动人员素质管理', '出租屋', '隔壁太吵了，影响休息', '梁大海', 'landlord#002', '2023-02-12', '处理中', '工作人员1号', 'staff@01', '法仔庄', '01', '');
INSERT INTO `staff@01_opinion` VALUES (12, '意见 0', '出租屋', '村庄内总是有很多外来车辆占用村民私人停车位', '梁大海', 'landlord#002', '2020-06-09', '已上报', '工作人员1号', 'staff@02', '法仔庄', '01', '');
INSERT INTO `staff@01_opinion` VALUES (14, '意见 3', '巡查工作', '测试', '梁爷爷', 'landlord#001', '2023-04-08', '否决意见', '工作人员1号', 'staff@01', '法仔庄', '01', '555');
INSERT INTO `staff@01_opinion` VALUES (15, '意见 0', '巡查工作', '针对上次巡查指出的监控问题，我觉得不是问题，目前我家出租屋安装的是最新款的高清4k监控。', '梁爷爷', 'landlord#001', '2023-04-06', '接纳意见', '工作人员1号', 'staff@01', '法仔庄', '01', '再去看看');
INSERT INTO `staff@01_opinion` VALUES (17, '意见 2', '流动人员', '建议保留一年内来往流动人员的记录', '梁爷爷', 'landlord#001', '2023-03-02', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', '');
INSERT INTO `staff@01_opinion` VALUES (18, '意见 7', '相关管理', '工作人员对出租屋管理的工作分多少模块呢', '梁爷爷', 'landlord#001', '2022-11-20', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', '');
INSERT INTO `staff@01_opinion` VALUES (20, '维修村门口的路灯', '相关管理', '能不能尽快通知维修，晚上都看不见路', '梁爷爷', 'landlord#001', '2023-04-14', '处理中', '工作人员1号', 'staff@01', '法仔庄', '01', '测试');
INSERT INTO `staff@01_opinion` VALUES (23, 'opinion', '其他', 'test\n', '梁大海', 'landlord#002', '2022-09-15', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', NULL);
INSERT INTO `staff@01_opinion` VALUES (26, '测试', '相关管理', '测试', '梁大海', 'landlord#002', '2023-05-01', '等待反馈', '工作人员1号', 'undefined', '法仔庄', '01', NULL);
INSERT INTO `staff@01_opinion` VALUES (27, 'test', '出租屋事务', 'test', '梁旭', 'landlord#004', '2023-05-02', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', NULL);
INSERT INTO `staff@01_opinion` VALUES (28, 'test 2', '其他', 'test 2', '梁旭', 'landlord#004', '2023-03-05', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', NULL);
INSERT INTO `staff@01_opinion` VALUES (29, 'test 3', '巡查工作', 'test ', '梁旭', 'landlord#004', '2023-05-03', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', NULL);
INSERT INTO `staff@01_opinion` VALUES (30, 'test opinion X', '出租屋事务', 'test', '梁爷爷', 'landlord#001', '2023-03-01', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', NULL);
INSERT INTO `staff@01_opinion` VALUES (31, 'test X', '流动人员', 'test', '梁爷爷', 'landlord#001', '2023-05-13', '等待反馈', '工作人员1号', 'staff@01', '法仔庄', '01', NULL);

-- ----------------------------
-- Table structure for staff@02_inspectation
-- ----------------------------
DROP TABLE IF EXISTS `staff@02_inspectation`;
CREATE TABLE `staff@02_inspectation`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Area` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HouseNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Owner` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '屋主',
  `Time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '巡查时间',
  `StaffName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员姓名',
  `Staff_ID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员ID',
  `Overall` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '总体巡查情况（合格、不合格）',
  `EntranceGuard` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '门禁安装：有、无',
  `ServeillanceSystem` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '监控系统',
  `FireSafety` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '消防安全：合格、存在隐患',
  `Sanitry` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '卫生条件：合格、需要整理',
  `Structural` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '结构安全：合格、存在隐患',
  `Circuit` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电路安全：合格、存在隐患',
  `Other` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '其他：合格、存在隐患',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FailReason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No`) USING BTREE,
  INDEX `Name`(`Title`) USING BTREE,
  INDEX `Inspectation_staff`(`Staff_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff@02_inspectation
-- ----------------------------
INSERT INTO `staff@02_inspectation` VALUES (23, '巡检 0', '矜用庄', '一巷5号', '梁超妍', '2023-04-02', '工作人员2号', 'staff@02', '合格', '已安装', '未安装', '合格', '存在隐患', '合格', '合格', '', '', '');
INSERT INTO `staff@02_inspectation` VALUES (24, 'test', '矜用庄', '二巷3号', '梁伟文', '2023-05-02', '工作人员2号', 'staff@02', '合格', '已安装', '已安装', '合格', '存在隐患', '合格', '合格', '', '', '');
INSERT INTO `staff@02_inspectation` VALUES (25, 'test 2', '矜用庄', '五巷4号', '梁天赋', '2023-03-02', '工作人员2号', 'staff@02', '合格', '未安装', '未安装', '合格', '合格', '合格', '合格', '', '', '');

-- ----------------------------
-- Table structure for staff@02_opinion
-- ----------------------------
DROP TABLE IF EXISTS `staff@02_opinion`;
CREATE TABLE `staff@02_opinion`  (
  `No` int(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `Title` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `Category` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '类别：出租屋、服务站管理、活动、其他',
  `Detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '具体',
  `LandlordName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Landlord_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SubmitTime` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '提交意见时间',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '阶段：已上报、接纳、否定',
  `StaffName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Staff_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员ID',
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AreaID` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Response` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '回复',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff@02_opinion
-- ----------------------------
INSERT INTO `staff@02_opinion` VALUES (22, '我的意见 0', '出租屋事务', '没有意见', '梁茶', 'landlord#101', '2023-02-05', '接纳意见', '工作人员2号', 'staff@02', '矜用庄', '11', '好的，我会认真考虑你的意见');
INSERT INTO `staff@02_opinion` VALUES (23, '意见 1', '流动人员', 'test', '梁茶', 'landlord#101', '2022-11-13', '处理中', '工作人员2号', 'staff@02', '矜用庄', '11', '');
INSERT INTO `staff@02_opinion` VALUES (24, '意见 2', '相关管理', '要是可以加强一下相关管理工作就好了', '梁茶', 'landlord#101', '2023-02-28', '接纳意见', '工作人员2号', 'staff@02', '矜用庄', '11', '好的');
INSERT INTO `staff@02_opinion` VALUES (25, '新来的租户好像奇怪', '流动人员', '房间里面晚上总是会发出不知道什么的声音，影响到隔壁的租户，敲门也没有回应，第二天跟他反应就说只是在睡觉', '梁茶', 'landlord#101', '2023-02-19', '否决意见', '工作人员2号', 'staff@02', '矜用庄', '11', '下周上班我去看看，还有什么别的信息可以提供呢？');
INSERT INTO `staff@02_opinion` VALUES (26, '关于上次巡查', '出租屋事务', '对于上次巡查说的问题，不是很理解，但是已经做出要求的相应改变', '梁茶', 'landlord#101', '2023-01-01', '等待反馈', '工作人员2号', 'undefined', '矜用庄', '11', NULL);
INSERT INTO `staff@02_opinion` VALUES (27, '意见 100', '其他', '测试', '梁茶', 'landlord#101', '2022-09-13', '接纳意见', '工作人员2号', 'staff@02', '矜用庄', '11', '处理中');
INSERT INTO `staff@02_opinion` VALUES (28, '我的意见', '出租屋事务', '无', '梁瞌睡', 'landlord#102', '2023-03-14', '等待反馈', '工作人员2号', 'staff@02', '矜用庄', '11', NULL);
INSERT INTO `staff@02_opinion` VALUES (29, 'opinion 0', '巡查工作', '不是的', '梁瞌睡', 'landlord#102', '2023-04-05', '否决意见', '工作人员2号', 'staff@02', '矜用庄', '11', '好');
INSERT INTO `staff@02_opinion` VALUES (31, '关于不定时抽检', '巡查工作', '无', '梁瞌睡', 'landlord#102', '2022-11-07', '等待反馈', '工作人员2号', 'staff@02', '矜用庄', '11', NULL);
INSERT INTO `staff@02_opinion` VALUES (32, '疫情防控', '出租屋事务', '进入出租屋好多人都不戴口罩，还是得注意一下', '梁瞌睡', 'landlord#102', '2022-09-02', '处理中', '工作人员2号', 'staff@02', '矜用庄', '11', '等我去贴张告示');
INSERT INTO `staff@02_opinion` VALUES (33, 'test', '巡查工作', 'test', '梁伟文', 'landlord#103', '2023-05-02', '等待反馈', '工作人员2号', 'staff@02', '矜用庄', '11', NULL);
INSERT INTO `staff@02_opinion` VALUES (34, 'test 2', '其他', 'test', '梁伟文', 'landlord#103', '2023-03-09', '接纳意见', '工作人员2号', 'staff@02', '矜用庄', '11', 'test');
INSERT INTO `staff@02_opinion` VALUES (35, 'test 3', '出租屋事务', 'test', '梁伟文', 'landlord#103', '2022-11-11', '处理中', '工作人员2号', 'staff@02', '矜用庄', '11', 'test');
INSERT INTO `staff@02_opinion` VALUES (36, 'test', '相关管理', 'test', '梁伟文', 'landlord#103', '2023-05-05', '等待反馈', '工作人员2号', 'staff@02', '矜用庄', '11', NULL);

-- ----------------------------
-- Table structure for tenant_landlord#001
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#001`;
CREATE TABLE `tenant_landlord#001`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#001
-- ----------------------------
INSERT INTO `tenant_landlord#001` VALUES (12, '502', 'test test', '440123123123123123', '13454321345', '33(已删除)', '租约结束', '2023-03-05', '4个月', '女', '已婚已育', '广东潮州', '', 'X', '√');
INSERT INTO `tenant_landlord#001` VALUES (14, '602', 't tenant1', '421565656565656565', '13498989898', '31', '租约中', '2023-03-01', '半年', '男', '单身未育', '广州', '', '√', '√');
INSERT INTO `tenant_landlord#001` VALUES (18, '501', 'test - rent', '440114897939383833', '13423222222', '30', '租约结束', '2022-11-05', '一年', '男', '单身未育', '新疆乌鲁木齐', '', '√', '√');
INSERT INTO `tenant_landlord#001` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (21, '504', 't', '440343434343434343', '13467565656', '36', '租约结束', '2023-01-08', '5个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (22, '603', 't0', '440112989843566545', '13198324242', '37', '租约中', '2023-02-05', '4个月', '男', '单身未育', '广州', '', '√', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', '女', '已婚已育', '香港', '', '√', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (24, '404', 'testdd', '440121767636485721', '15972378267', '39(已删除)', '租约结束', '2023-02-12', '5个月', NULL, NULL, NULL, NULL, 'X', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (25, '504', '梁超妍', '440221787875757575', '15733333333', '40', '租约结束', '2023-04-02', '3个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约中', '2023-04-01', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (28, '403', '梁超妍', '440121200109270429', '13763334852', '43', '租约中', '2023-02-11', '半年', '男', '已婚未育', '上海', 'undefined', '√', '√');
INSERT INTO `tenant_landlord#001` VALUES (29, '606', '罗杰夫', '440121200001010422', '13764487294', '44', '租约中', '2023-02-15', '半年', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#001` VALUES (30, '404', '陈奕迅', '440114200109270429', '13769927493', '45', '租约中', '2022-11-02', '7个月', '女', '单身已育', '广东潮汕', '', '√', '未报备');

-- ----------------------------
-- Table structure for tenant_landlord#002
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#002`;
CREATE TABLE `tenant_landlord#002`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#002
-- ----------------------------
INSERT INTO `tenant_landlord#002` VALUES (18, '501', 'test - rent', '440114897939383833', '13423222222', '30(已删除)', '租约结束', '2022-11-05', '一年', '男', '单身未育', '新疆乌鲁木齐', '', 'X', '√');
INSERT INTO `tenant_landlord#002` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', '男', '单身未育', '揭阳', '', '√', '√');
INSERT INTO `tenant_landlord#002` VALUES (22, '603', 't0', '440112989843566545', '13198324242', '37', '租约中', '2023-02-05', '4个月', '女', '已婚已育', '潮州', '', '√', '√');
INSERT INTO `tenant_landlord#002` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', '女', '单身未育', '中国上海', '', '√', '√');
INSERT INTO `tenant_landlord#002` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约中', '2023-04-01', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#002` VALUES (29, '606', '罗杰夫', '440121200001010422', '13764487294', '44', '租约中', '2023-02-15', '半年', '男', '已婚未育', '山东', '', '√', '√');
INSERT INTO `tenant_landlord#002` VALUES (30, '401', '孙尚香', '440114200304938213', '13874492753', '45', '租约中', '2023-03-08', '半年', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#002` VALUES (31, '404', '小梁', '440114200893859333', '13875558244', '46', '租约中', '2023-05-02', '4个月', '男', '单身未育', '中国香港', '', '√', '√');
INSERT INTO `tenant_landlord#002` VALUES (32, 'test', '小罗', '449114939393939393', '13522222222', '47', '租约结束', '2023-04-09', '半年', NULL, NULL, NULL, NULL, '待完善', '未报备');

-- ----------------------------
-- Table structure for tenant_landlord#003
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#003`;
CREATE TABLE `tenant_landlord#003`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#003
-- ----------------------------
INSERT INTO `tenant_landlord#003` VALUES (12, '502', 'test test', '440123123123123123', '13454321345', '33(已删除)', '租约结束', '2023-03-05', '4个月', '女', '已婚已育', '广东潮州', '', 'X', '√');
INSERT INTO `tenant_landlord#003` VALUES (14, '602', 't tenant1', '421565656565656565', '13498989898', '31', '租约中', '2023-03-01', '半年', '男', '单身未育', '广州', '', '√', '√');
INSERT INTO `tenant_landlord#003` VALUES (15, '603', 'test - rentDelete', '440214564235345342', '18745453122', '28', '租约结束', '2023-04-05', '半年', '女', '已婚未育', '广东东莞', '', '√', '√');
INSERT INTO `tenant_landlord#003` VALUES (18, '501', 'test - rent', '440114897939383833', '13423222222', '30', '租约结束', '2022-11-05', '一年', '男', '单身未育', '新疆乌鲁木齐', '', '√', '√');
INSERT INTO `tenant_landlord#003` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', '男', '单身已育', '江门', '', '√', '√');
INSERT INTO `tenant_landlord#003` VALUES (21, '504', 't', '440343434343434343', '13467565656', '36', '租约结束', '2023-01-08', '5个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#003` VALUES (22, '603', 't0', '440112989843566545', '13198324242', '37', '租约中', '2023-02-05', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#003` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#003` VALUES (24, '404', 'testdd', '440121767636485721', '15972378267', '39(已删除)', '租约结束', '2023-02-12', '5个月', NULL, NULL, NULL, NULL, 'X', '未报备');
INSERT INTO `tenant_landlord#003` VALUES (25, '504', '梁超妍', '440221787875757575', '15733333333', '40', '租约结束', '2023-04-02', '3个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#003` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约中', '2023-04-01', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#003` VALUES (28, '403', '梁超妍', '440121200109270429', '13763334852', '43', '租约中', '2023-02-11', '半年', '男', '已婚未育', '上海', 'undefined', '√', '√');
INSERT INTO `tenant_landlord#003` VALUES (29, '606', '罗杰夫', '440121200001010422', '13764487294', '44', '租约中', '2023-02-15', '半年', NULL, NULL, NULL, NULL, '待完善', '未报备');

-- ----------------------------
-- Table structure for tenant_landlord#004
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#004`;
CREATE TABLE `tenant_landlord#004`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#004
-- ----------------------------
INSERT INTO `tenant_landlord#004` VALUES (12, '502', 'test test', '440123123123123123', '13454321345', '33(已删除)', '租约结束', '2023-03-05', '4个月', '女', '已婚已育', '广东潮州', '', 'X', '√');
INSERT INTO `tenant_landlord#004` VALUES (14, '602', 't tenant1', '421565656565656565', '13498989898', '31', '租约中', '2023-03-01', '半年', '男', '单身未育', '广州', '', '√', '√');
INSERT INTO `tenant_landlord#004` VALUES (15, '603', 'test - rentDelete', '440214564235345342', '18745453122', '28', '租约结束', '2023-04-05', '半年', '女', '已婚未育', '广东东莞', '', '√', '√');
INSERT INTO `tenant_landlord#004` VALUES (18, '501', 'test - rent', '440114897939383833', '13423222222', '30', '租约结束', '2022-11-05', '一年', '男', '单身未育', '新疆乌鲁木齐', '', '√', '√');
INSERT INTO `tenant_landlord#004` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', '男', '单身已育', '江门', '', '√', '√');
INSERT INTO `tenant_landlord#004` VALUES (21, '504', 't', '440343434343434343', '13467565656', '36', '租约结束', '2023-01-08', '5个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#004` VALUES (22, '603', 't0', '440112989843566545', '13198324242', '37', '租约中', '2023-02-05', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#004` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#004` VALUES (24, '404', 'testdd', '440121767636485721', '15972378267', '39(已删除)', '租约结束', '2023-02-12', '5个月', NULL, NULL, NULL, NULL, 'X', '未报备');
INSERT INTO `tenant_landlord#004` VALUES (25, '504', '梁超妍', '440221787875757575', '15733333333', '40', '租约结束', '2023-04-02', '3个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#004` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约中', '2023-04-01', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#004` VALUES (28, '403', '梁超妍', '440121200109270429', '13763334852', '43', '租约中', '2023-02-11', '半年', '男', '已婚未育', '上海', 'undefined', '√', '√');
INSERT INTO `tenant_landlord#004` VALUES (29, '606', '罗杰夫', '440121200001010422', '13764487294', '44', '租约中', '2023-02-15', '半年', NULL, NULL, NULL, NULL, '待完善', '未报备');

-- ----------------------------
-- Table structure for tenant_landlord#101
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#101`;
CREATE TABLE `tenant_landlord#101`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#101
-- ----------------------------
INSERT INTO `tenant_landlord#101` VALUES (14, '602', 't tenant1', '421565656565656565', '13498989898', '31', '租约中', '2023-03-01', '半年', '男', '单身未育', '广州', '', '√', '√');
INSERT INTO `tenant_landlord#101` VALUES (15, '603', 'test - rentDelete', '440214564235345342', '18745453122', '28(已删除)', '租约结束', '2023-04-05', '半年', '女', '已婚未育', '广东东莞', '', 'X', '√');
INSERT INTO `tenant_landlord#101` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', '女', '单身未育', '香港', '', '√', '未报备');
INSERT INTO `tenant_landlord#101` VALUES (22, '603', 't0', '440112989843566545', '13198324242', '37', '租约中', '2023-02-05', '4个月', '男', '单身未育', '上海', '', '√', '未报备');
INSERT INTO `tenant_landlord#101` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', NULL, NULL, NULL, NULL, '待完善', '未报备');
INSERT INTO `tenant_landlord#101` VALUES (24, '404', 'testdd', '440121767636485721', '15972378267', '39(已删除)', '租约结束', '2023-02-12', '5个月', NULL, NULL, NULL, NULL, 'X', '未报备');
INSERT INTO `tenant_landlord#101` VALUES (25, '504', '梁超妍', '440221787875757575', '15733333333', '40(已删除)', '租约结束', '2023-04-02', '3个月', NULL, NULL, NULL, NULL, 'X', '未报备');
INSERT INTO `tenant_landlord#101` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约结束', '2023-04-01', '4个月', '男', '单身已育', '广西柳州', 'undefined', '√', '未报备');
INSERT INTO `tenant_landlord#101` VALUES (28, '403', '梁超妍', '440121200109270429', '13763334852', '43', '租约中', '2023-02-11', '半年', '男', '已婚未育', '上海', 'undefined', '√', '√');
INSERT INTO `tenant_landlord#101` VALUES (30, '502', '田柾国', '440114200109270429', '13763334852', '45', '租约中', '2023-01-15', '一年', '男', '单身未育', '广东广州', 'undefined', '√', '未报备');

-- ----------------------------
-- Table structure for tenant_landlord#102
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#102`;
CREATE TABLE `tenant_landlord#102`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#102
-- ----------------------------
INSERT INTO `tenant_landlord#102` VALUES (12, '502', 'test test', '440123123123123123', '13454321345', '33(已删除)', '租约结束', '2023-03-05', '4个月', '女', '已婚已育', '广东潮州', 'X', '√', '');
INSERT INTO `tenant_landlord#102` VALUES (14, '602', 't tenant1', '421565656565656565', '13498989898', '31', '租约中', '2023-03-01', '半年', '男', '单身未育', '广州', '√', '√', '');
INSERT INTO `tenant_landlord#102` VALUES (15, '603', 'test - rentDelete', '440214564235345342', '18745453122', '28(已删除)', '租约结束', '2023-04-05', '半年', '女', '已婚未育', '广东东莞', 'X', '√', '');
INSERT INTO `tenant_landlord#102` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', NULL, NULL, NULL, '待完善', '未报备', NULL);
INSERT INTO `tenant_landlord#102` VALUES (21, '504', 't', '440343434343434343', '13467565656', '36', '租约结束', '2023-01-08', '5个月', NULL, NULL, NULL, '待完善', '未报备', NULL);
INSERT INTO `tenant_landlord#102` VALUES (22, '603', 't0', '440112989843566545', '13198324242', '37', '租约结束', '2023-02-05', '4个月', '男', '已婚未育', '香港', '√', '√', '');
INSERT INTO `tenant_landlord#102` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', '男', '已婚已育', '广东广州', '√', '√', '');
INSERT INTO `tenant_landlord#102` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约中', '2023-04-01', '4个月', NULL, NULL, NULL, '待完善', '未报备', NULL);
INSERT INTO `tenant_landlord#102` VALUES (28, '403', '梁超妍', '440121200109270429', '13763334852', '43', '租约中', '2023-02-11', '半年', '男', '已婚未育', '上海', '√', '√', 'undefined');
INSERT INTO `tenant_landlord#102` VALUES (29, '606', '罗杰夫', '440121200001010422', '13764487294', '44', '租约中', '2023-02-15', '半年', '女', '单身已育', '上海', '√', '√', '');
INSERT INTO `tenant_landlord#102` VALUES (30, '401', 'test last', '440114120492059305', '13453544332', '45', '租约结束', '2023-04-01', '半年', NULL, NULL, NULL, '待完善', '未报备', NULL);

-- ----------------------------
-- Table structure for tenant_landlord#103
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#103`;
CREATE TABLE `tenant_landlord#103`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#103
-- ----------------------------
INSERT INTO `tenant_landlord#103` VALUES (14, '602', 't tenant1', '421565656565656565', '13498989898', '31', '租约中', '2023-03-01', '半年', '男', '单身未育', '广州', '√', '√', '');
INSERT INTO `tenant_landlord#103` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', '女', '已婚未育', '广州', '√', '√', '');
INSERT INTO `tenant_landlord#103` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', '男', '已婚已育', '广东广州', '√', '√', '');
INSERT INTO `tenant_landlord#103` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约中', '2023-04-01', '4个月', NULL, NULL, NULL, '待完善', '未报备', NULL);
INSERT INTO `tenant_landlord#103` VALUES (28, '403', '梁超妍', '440121200109270429', '13763334852', '43', '租约中', '2023-02-11', '半年', '男', '已婚未育', '上海', '√', '√', 'undefined');
INSERT INTO `tenant_landlord#103` VALUES (29, '606', '罗杰夫', '440121200001010422', '13764487294', '44', '租约中', '2023-02-15', '半年', '女', '单身已育', '上海', '√', '√', '');

-- ----------------------------
-- Table structure for tenant_landlord#104
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#104`;
CREATE TABLE `tenant_landlord#104`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#104
-- ----------------------------
INSERT INTO `tenant_landlord#104` VALUES (14, '602', 't tenant1', '421565656565656565', '13498989898', '31', '租约中', '2023-03-01', '半年', '男', '单身未育', '广州', '√', '√', '');
INSERT INTO `tenant_landlord#104` VALUES (20, '601', 'tt', '440121989898989898', '13298989898', '35', '租约中', '2022-05-07', '一年', '女', '已婚未育', '广州', '√', '未报备', '');
INSERT INTO `tenant_landlord#104` VALUES (23, '505', 'test -', '440485878787878787', '18765656565', '38', '租约中', '2023-03-27', '4个月', '男', '已婚已育', '广东广州', '√', '√', '');
INSERT INTO `tenant_landlord#104` VALUES (27, '501', 'test 8', '440235445434311342', '13422986743', '42', '租约中', '2023-04-01', '4个月', NULL, NULL, NULL, '待完善', '未报备', NULL);
INSERT INTO `tenant_landlord#104` VALUES (28, '403', '梁超妍', '440121200109270429', '13763334852', '43', '租约中', '2023-02-11', '半年', '男', '已婚未育', '上海', '√', '√', 'undefined');
INSERT INTO `tenant_landlord#104` VALUES (29, '606', '罗杰夫', '440121200001010422', '13764487294', '44', '租约中', '2023-02-15', '半年', '女', '单身已育', '上海', '√', '√', '');

-- ----------------------------
-- Table structure for tenant_landlord#105
-- ----------------------------
DROP TABLE IF EXISTS `tenant_landlord#105`;
CREATE TABLE `tenant_landlord#105`  (
  `No` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房间号',
  `Name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `Tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `ContractNo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '合同编号',
  `ContractStage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StartDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起租日',
  `Term` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Marriage` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Origin` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息待完善',
  `ReportStatus` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '未报备，已报备',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_landlord#105
-- ----------------------------

-- ----------------------------
-- Table structure for website_landlord
-- ----------------------------
DROP TABLE IF EXISTS `website_landlord`;
CREATE TABLE `website_landlord`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `AreaID` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HouseNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Landlord_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '房东ID',
  `LandlordName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Cover1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Cover2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Cover3` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Cover4` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Brief` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '简介\r\n',
  `Contact` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '联系方式',
  `More` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '更多资讯',
  `IsCurrent` int UNSIGNED NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of website_landlord
-- ----------------------------
INSERT INTO `website_landlord` VALUES (1, '法仔庄', '01', '七巷1号', 'landlord#001', '梁爷爷', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/42.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/7868.png', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/images.jpg', '七巷1号坐落于村庄风景最好的位置，站在天台可以将整个村庄的美景尽收眼底，视野开阔，空气清新。\n\n出租屋有各种不同的房型，设置配备齐全。周边有大型的购物中心，楼下可购买停车服务。', '13422198198', '早春招租优惠方案：同时租两间出租屋减免20%押金！', 0);
INSERT INTO `website_landlord` VALUES (2, '法仔庄', '01', '八巷2号', 'landlord#002', '梁大海', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/32.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/fds.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/7868.png', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/6543.jpg', '各种房型一应俱全，有适合一家5口居住的两室一厅。也有适合爱宅家社恐的单间出租。\n为了保障大家的安全，房东大哥哥每天巡查，摄像头无死角监控，门禁刷脸识别。\n天台设置餐吧，无论是饿了还是emo，无论什么时候都可以上天台噢，这是一个可以给离家人温暖的出租屋！', '189545427605', '快来！这家出租屋提供晚饭和宵夜，再也不用半夜出门“深夜食堂”啦', 0);
INSERT INTO `website_landlord` VALUES (3, '法仔庄', '01', '五巷3号', 'landlord#003', '梁超妍', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/3.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/523.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/fds.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/645.jpeg', '这里将会是你打工生涯美好的家。\n拎包入住。5GWIFI，提供钟点工清洁服务（需付费），酒店式出租屋。\n交通便利，环境清幽，出租屋隔音优秀，半夜三更打游戏唱k都丝毫不影响邻居休息，完全放心的刷脸进门，不用担心被盗或人身安全。\n房东叫你快点来租房啦啦啦。', '13578884521', '最后半年降价出租，因为准备装修啦。', 1);
INSERT INTO `website_landlord` VALUES (4, '矜用庄', '11', '二巷1号', 'landlord#101', '梁茶', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/5435.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/rte.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/%E8%BD%BD.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/42.jpeg', '这里将会是你打工生涯美好的家。\n坐落于三东村矜用庄村口，出门5分钟即可到达公交车站，大型商超骏一万邦就在家门口。\n房东小姐姐热心好客，不定期举办暖房活动，快来加入楼房大家庭吧。', '13422794456', '房屋整体于23年2月翻新完毕', 1);
INSERT INTO `website_landlord` VALUES (5, '矜用庄', '11', '一巷5号', 'landlord#102', '梁超妍', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/534.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/images.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/6543.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/1.jpg', '6层高的楼房，一应俱全的配置设施，楼下有可租用的电动车充电器和汽车停车场。\n为了保障租客安全，每层楼都设置高清监控摄像头，楼下入口刷脸识别或指纹认证。\n房东由衷欢迎大家入住。', '13456668576', '会在天台不定期举办出租屋暖房活动（免费的哟）', 0);
INSERT INTO `website_landlord` VALUES (6, '法仔庄', '01', '一巷6号', 'landlord#004', '梁旭', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/542%E4%BA%94.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/523.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/fds.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/2.jpg', '这里将会是你打工生涯美好的家。\n拎包入住。5GWIFI，提供钟点工清洁服务（需付费），酒店式出租屋。\n交通便利，环境清幽，出租屋隔音优秀，半夜三更打游戏唱k都丝毫不影响邻居休息，完全放心的刷脸进门，不用担心被盗或人身安全。\n房东叫你快点来租房啦啦啦。', '13578884521', '最后半年降价出租，因为准备装修啦。', 0);
INSERT INTO `website_landlord` VALUES (7, '矜用庄', '11', '二巷3号', 'landlord#103', '梁伟文', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/42.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/rte.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/%E8%BD%BD.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/images.jpg', '这里将会是你打工生涯美好的家。\n坐落于三东村矜用庄村口，出门5分钟即可到达公交车站，大型商超骏一万邦就在家门口。\n房东小姐姐热心好客，不定期举办暖房活动，快来加入楼房大家庭吧。', '13422794456', '房屋整体于23年2月翻新完毕', 0);
INSERT INTO `website_landlord` VALUES (8, '矜用庄', '11', '八巷3号', 'landlord#104', '梁小姐', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/5435.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/rte.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/%E8%BD%BD.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/42.jpeg', '这里将会是你打工生涯美好的家。\n坐落于三东村矜用庄村口，出门5分钟即可到达公交车站，大型商超骏一万邦就在家门口。\n房东小姐姐热心好客，不定期举办暖房活动，快来加入楼房大家庭吧。', '13422794456', '房屋整体于23年2月翻新完毕', 0);
INSERT INTO `website_landlord` VALUES (9, '矜用庄', '11', '五巷4号', 'landlord#105', '梁天赋', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/5435.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/rte.jpeg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/%E8%BD%BD.jpg', 'https:liangchaoyan-1317602792.cos.ap-guangzhou.myqcloud.com/42.jpeg', '这里将会是你打工生涯美好的家。\n坐落于三东村矜用庄村口，出门5分钟即可到达公交车站，大型商超骏一万邦就在家门口。\n房东小姐姐热心好客，不定期举办暖房活动，快来加入楼房大家庭吧。', '13422794456', '房屋整体于23年2月翻新完毕', 0);

-- ----------------------------
-- Table structure for website_staff
-- ----------------------------
DROP TABLE IF EXISTS `website_staff`;
CREATE TABLE `website_staff`  (
  `No` int NOT NULL AUTO_INCREMENT,
  `Area` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AreaID` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Staff_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Brief` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '村庄简介：交通位置、周边环境',
  `Location` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Contact` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工作人员联系方式',
  `Office` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HouseCount` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsCurrent` int NOT NULL,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of website_staff
-- ----------------------------
INSERT INTO `website_staff` VALUES (1, '法仔庄', '01', 'staff@01', '法仔庄位于花城街道三东村二十一队，毗邻骏威小学、骏一万邦，村庄环境自然舒适，空气清新。', '广州市花都区花城街道法仔庄大街', '13763334877', '村委会三东村服务站', '5', 1);
INSERT INTO `website_staff` VALUES (2, '矜用庄', '11', 'staff@02', '矜用庄与花都新商圈骏一万邦背靠背，距离新政务中心也不过10分钟的步行路程，矜用庄地理位置得天独厚，走进就能感受到几十年历史与现代艺术文化相融合的感觉，狭窄的小巷，水泥砖瓦的咖啡厅，心旷神怡的居住环境，令人十分向往。', '广州市花都区花城街三东村矜用庄', '13763334848', '村委会', '2', 0);

SET FOREIGN_KEY_CHECKS = 1;
