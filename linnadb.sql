/*
 Navicat Premium Data Transfer

 Source Server         : 123.56.169.21
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : 123.56.169.21:3306
 Source Schema         : linnadb

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 20/10/2020 23:52:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pdt_chapter
-- ----------------------------
DROP TABLE IF EXISTS `pdt_chapter`;
CREATE TABLE `pdt_chapter`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_flag` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属课程的code_flag',
  `pid` int(11) NOT NULL COMMENT '章节父亲id，如果是一级目录（等于课程id）',
  `pids` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '当前章节所有的父章节id',
  `is_leaf` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0：不是叶子节点，1：是叶子节点',
  `chapter_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '章节名称',
  `file_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序序号',
  `level` int(11) NOT NULL COMMENT '章节目录层级',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0:显示，1:隐藏',
  `video_url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '本章节视频地址',
  `video_free` tinyint(1) NULL DEFAULT 0 COMMENT '本章节视频免费公开，1：是的',
  `text_free` tinyint(1) NULL DEFAULT 0 COMMENT '本章节文章免费公开，1：是的',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pdt_chapter
-- ----------------------------
INSERT INTO `pdt_chapter` VALUES (1, 'test', 0, '[0]', 0, '测试一', 'e502efbe-d114-4c4b-abdb-25fdd711aef0.md', NULL, 1, 0, NULL, 1, 1);
INSERT INTO `pdt_chapter` VALUES (2, 'test', 0, '[0]', 1, '测试二', 'd151ce33-8437-40c2-a688-f21f2ecd4339.md', NULL, 1, 0, NULL, 0, 0);
INSERT INTO `pdt_chapter` VALUES (3, 'test', 1, '[0],[1]', 1, '测试1-1-1', '8cf33b8c-20a6-41bd-9792-6371232a4127.md', NULL, 2, 0, NULL, 0, 1);
INSERT INTO `pdt_chapter` VALUES (17, 'test1', 0, '[0]', 1, '测试', '测试.md', NULL, 1, 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for pdt_course
-- ----------------------------
DROP TABLE IF EXISTS `pdt_course`;
CREATE TABLE `pdt_course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `brief` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `img_url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `git_url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程文件git仓库地址',
  `code_flag` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '英文标识(URI)',
  `free` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0:收费,1:免费',
  `open` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0:私有,1:公开',
  `owner_userid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文档归属用户username',
  `create_time` datetime(0) NOT NULL COMMENT '课程的创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code_flag`(`code_flag`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '课程' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pdt_course
-- ----------------------------
INSERT INTO `pdt_course` VALUES (1, '测试', '测试', 'http://komavideo.com/assets/markdown-f5682cd0ab8562fead3847792c21fccab70a0c57518a91f49c9b76b89666dd34.png', NULL, 'test', 1, 0, '13756106373', '2020-03-09 21:47:19');
INSERT INTO `pdt_course` VALUES (2, '测试', '测试', 'http://komavideo.com/assets/markdown-f5682cd0ab8562fead3847792c21fccab70a0c57518a91f49c9b76b89666dd34.png', NULL, 'test1', 1, 0, '13756106373', '2020-03-09 21:47:41');
INSERT INTO `pdt_course` VALUES (3, 'markdown入门教学', 'Markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。', 'http://komavideo.com/assets/markdown-f5682cd0ab8562fead3847792c21fccab70a0c57518a91f49c9b76b89666dd34.png', NULL, 'markdown', 0, 0, '13756106373', '2020-03-10 23:40:45');
INSERT INTO `pdt_course` VALUES (4, 'markdown入门教学（二）', 'Markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。', 'http://komavideo.com/assets/markdown-f5682cd0ab8562fead3847792c21fccab70a0c57518a91f49c9b76b89666dd34.png', NULL, 'markdown2', 0, 0, '13756106373', '2020-03-10 23:41:06');

-- ----------------------------
-- Table structure for pdt_user_cource
-- ----------------------------
DROP TABLE IF EXISTS `pdt_user_cource`;
CREATE TABLE `pdt_user_cource`  (
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `code_flag` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  UNIQUE INDEX `username_code_flag`(`username`, `code_flag`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户课程关联表(收费课程订购表)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pdt_user_cource
-- ----------------------------

-- ----------------------------
-- Table structure for sys_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_api`;
CREATE TABLE `sys_api`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_pid` int(11) NOT NULL COMMENT '接口父ID(即接口分组)',
  `api_pids` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '当前接口的所有上级id(即所有上级分组)',
  `is_leaf` tinyint(1) NOT NULL COMMENT '0:不是叶子节点，1:是叶子节点',
  `api_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接口名称',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转URL',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `level` int(11) NOT NULL COMMENT '层级，1：接口分组，2：接口',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统Http接口表，配合sys_role_api控制接口访问权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_api
-- ----------------------------
INSERT INTO `sys_api` VALUES (1, 0, '[0]', 0, '系统数据接口', NULL, 1, 1, 0);
INSERT INTO `sys_api` VALUES (2, 1, '[0],[1]', 0, '系统管理模块', NULL, 1, 2, 0);
INSERT INTO `sys_api` VALUES (3, 2, '[0],[1],[2]', 1, '用户信息接口', '/sysuser/info', 1, 3, 0);
INSERT INTO `sys_api` VALUES (4, 2, '[0],[1],[2]', 1, '组织管理-树形数据接口', '/sysorg/tree', 2, 3, 0);
INSERT INTO `sys_api` VALUES (5, 2, '[0],[1],[2]', 1, '组织管理-新增组织接口', '/sysorg/add', 3, 3, 0);
INSERT INTO `sys_api` VALUES (6, 2, '[0],[1],[2]', 1, '组织管理-修改组织接口', '/sysorg/update', 4, 3, 0);
INSERT INTO `sys_api` VALUES (7, 2, '[0],[1],[2]', 1, '组织管理-删除组织接口', '/sysorg/delete', 5, 3, 0);
INSERT INTO `sys_api` VALUES (8, 2, '[0],[1],[2]', 1, '菜单树形数据加载接口', '/sysmenu/tree', 6, 3, 0);
INSERT INTO `sys_api` VALUES (9, 2, '[0],[1],[2]', 1, '菜单管理-新增菜单项接口', '/sysmenu/add', 7, 3, 0);
INSERT INTO `sys_api` VALUES (10, 2, '[0],[1],[2]', 1, '菜单管理-修改菜单项接口', '/sysmenu/update', 8, 3, 0);
INSERT INTO `sys_api` VALUES (11, 2, '[0],[1],[2]', 1, '菜单管理-删除菜单项接口', '/sysmenu/delete', 9, 3, 0);
INSERT INTO `sys_api` VALUES (12, 2, '[0],[1],[2]', 1, '查询某角色已具备菜单权限接口', '/sysmenu/checkedtree', 10, 3, 0);
INSERT INTO `sys_api` VALUES (13, 2, '[0],[1],[2]', 1, '保存某角色分配勾选的菜单权限', '/sysmenu/savekeys', 11, 3, 0);
INSERT INTO `sys_api` VALUES (14, 2, '[0],[1],[2]', 1, '接口分类树形结构数据加载', '/sysapi/tree', 12, 3, 0);
INSERT INTO `sys_api` VALUES (15, 2, '[0],[1],[2]', 1, '接口管理-新增接口', '/sysapi/add', 13, 3, 0);
INSERT INTO `sys_api` VALUES (16, 2, '[0],[1],[2]', 1, '接口管理-更新接口数据', '/sysapi/update', 14, 3, 0);
INSERT INTO `sys_api` VALUES (17, 2, '[0],[1],[2]', 1, '接口管理-删除接口', '/sysapi/delete', 15, 3, 0);
INSERT INTO `sys_api` VALUES (18, 2, '[0],[1],[2]', 1, '查询某角色已具备的接口访问权限', '/sysapi/checkedtree', 16, 3, 0);
INSERT INTO `sys_api` VALUES (19, 2, '[0],[1],[2]', 1, '保存某角色勾选分配的接口访问权限', '/sysapi/savekeys', 17, 3, 0);
INSERT INTO `sys_api` VALUES (20, 2, '[0],[1],[2]', 1, '角色管理-列表查询', '/sysrole/query', 18, 3, 0);
INSERT INTO `sys_api` VALUES (21, 2, '[0],[1],[2]', 1, '角色管理-新增角色', '/sysrole/add', 19, 3, 0);
INSERT INTO `sys_api` VALUES (22, 2, '[0],[1],[2]', 1, '角色管理-更新角色数据', '/sysrole/update', 20, 3, 0);
INSERT INTO `sys_api` VALUES (23, 2, '[0],[1],[2]', 1, '角色管理-删除角色', '/sysrole/delete', 21, 3, 0);
INSERT INTO `sys_api` VALUES (24, 2, '[0],[1],[2]', 1, '查询某用户具备的角色id列表', '/sysrole/checkedroles', 22, 3, 0);
INSERT INTO `sys_api` VALUES (25, 2, '[0],[1],[2]', 1, '保存为某用户分配的角色', '/sysrole/savekeys', 23, 3, 0);
INSERT INTO `sys_api` VALUES (26, 2, '[0],[1],[2]', 1, '用户管理-用户列表查询', '/sysuser/query', 24, 3, 0);
INSERT INTO `sys_api` VALUES (27, 2, '[0],[1],[2]', 1, '用户管理-新增用户', '/sysuser/add', 25, 3, 0);
INSERT INTO `sys_api` VALUES (28, 2, '[0],[1],[2]', 1, '用户管理-修改用户信息', '/sysuser/update', 26, 3, 0);
INSERT INTO `sys_api` VALUES (29, 2, '[0],[1],[2]', 1, '用户管理-删除用户', '/sysuser/delete', 27, 3, 0);
INSERT INTO `sys_api` VALUES (30, 2, '[0],[1],[2]', 1, '为用户重置密码', '/sysuser/pwd/reset2', 28, 3, 0);
INSERT INTO `sys_api` VALUES (31, 2, '[0],[1],[2]', 1, '判断用户是否使用默认密码', '/sysuser/pwd/isdefault', 29, 3, 0);
INSERT INTO `sys_api` VALUES (32, 2, '[0],[1],[2]', 1, '修改用户密码', '/sysuser/pwd/change', 30, 3, 0);
INSERT INTO `sys_api` VALUES (33, 2, '[0],[1],[2]', 1, '菜单栏数据接口(根据登录用户)', '/sysmenu/tree/user', 6, 3, 0);
INSERT INTO `sys_api` VALUES (34, 2, '[0],[1],[2]', 1, '获取系统全局配置参数', '/sysconfig/all', 31, 3, 0);
INSERT INTO `sys_api` VALUES (35, 2, '[0],[1],[2]', 1, '条件查询全局配置参数接口', '/sysconfig/query', 32, 3, 0);
INSERT INTO `sys_api` VALUES (36, 2, '[0],[1],[2]', 1, '新增配置参数接口', '/sysconfig/add', 33, 3, 0);
INSERT INTO `sys_api` VALUES (37, 2, '[0],[1],[2]', 1, '修改配置参数接口', '/sysconfig/update', 34, 3, 0);
INSERT INTO `sys_api` VALUES (38, 2, '[0],[1],[2]', 1, '删除配置参数接口', '/sysconfig/delete', 35, 3, 0);
INSERT INTO `sys_api` VALUES (39, 2, '[0],[1],[2]', 1, '配置参数从数据库刷新到内存', '/sysconfig/refresh', 36, 3, 0);
INSERT INTO `sys_api` VALUES (40, 2, '[0],[1],[2]', 1, '数据字典数据加载接口', '/sysdict/all', 37, 3, 0);
INSERT INTO `sys_api` VALUES (41, 2, '[0],[1],[2]', 1, '数据字典条件查询接口', '/sysdict/query', 38, 3, 0);
INSERT INTO `sys_api` VALUES (42, 2, '[0],[1],[2]', 1, '数据字典数据新增接口', '/sysdict/add', 39, 3, 0);
INSERT INTO `sys_api` VALUES (43, 2, '[0],[1],[2]', 1, '数据字典数据修改接口', '/sysdict/update', 40, 3, 0);
INSERT INTO `sys_api` VALUES (44, 2, '[0],[1],[2]', 1, '数据字典数据删除接口', '/sysdict/delete', 41, 3, 0);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数名称(中文)',
  `param_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数编码唯一标识(英文及数字)',
  `param_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数值',
  `param_desc` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数描述备注',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `param_key`(`param_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统全局配置参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '用户初始密码', 'user.init.password', 'abcd1234', '系统新增用户初始化密码（登录后会提示用户自行修改）', '2020-02-29 13:26:58');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `group_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组编码',
  `item_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典项名称',
  `item_value` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典项Value',
  `item_desc` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项描述',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '字典项创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, '是否禁用', 'common.status', '未禁用', 'false', '通用数据记录的禁用状态', '2020-02-29 17:00:16');
INSERT INTO `sys_dict` VALUES (2, '是否禁用', 'common.status', '已禁用', 'true', '通用数据记录的禁用状态', '2020-02-29 17:00:26');
INSERT INTO `sys_dict` VALUES (3, '用户状态', 'sysuser.enabled', '已激活', 'true', '用户状态', '2020-02-29 18:42:08');
INSERT INTO `sys_dict` VALUES (4, '用户状态', 'sysuser.enabled', '已禁用', 'false', '用户状态', '2020-02-29 23:23:35');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_pid` int(11) NOT NULL COMMENT '父菜单ID',
  `menu_pids` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '当前菜单所有父菜单',
  `is_leaf` tinyint(1) NOT NULL COMMENT '0:不是叶子节点，1:是叶子节点',
  `menu_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转URL',
  `icon` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `level` int(11) NOT NULL COMMENT '菜单层级',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '[0]', 0, '系统根目录', '/', '', 1, 1, 0);
INSERT INTO `sys_menu` VALUES (2, 1, '[0],[1]', 0, '系统管理', '/system', 'el-icon-fa fa-cogs', 1, 2, 0);
INSERT INTO `sys_menu` VALUES (3, 2, '[0],[1],[2]', 1, '用户管理', '/home/sysuser', 'el-icon-fa fa-user', 1, 3, 0);
INSERT INTO `sys_menu` VALUES (4, 2, '[0],[1],[2]', 1, '角色管理', '/home/sysrole', 'el-icon-fa fa-users', 2, 3, 0);
INSERT INTO `sys_menu` VALUES (5, 2, '[0],[1],[2]', 1, '组织管理', '/home/sysorg', 'el-icon-fa fa-sitemap', 3, 3, 0);
INSERT INTO `sys_menu` VALUES (6, 2, '[0],[1],[2]', 1, '菜单管理', '/home/sysmenu', 'el-icon-fa fa-list-ul', 4, 3, 0);
INSERT INTO `sys_menu` VALUES (7, 2, '[0],[1],[2]', 1, '接口管理', '/home/sysapi', 'el-icon-fa fa-plug', 5, 3, 1);
INSERT INTO `sys_menu` VALUES (10, 1, '[0],[1]', 0, '测试用菜单', '/order', 'el-icon-eleme', 2, 2, 0);
INSERT INTO `sys_menu` VALUES (11, 10, '[0],[1],[10]', 1, '子菜单(首页)', '/home/firstpage', 'el-icon-lock', 1, 3, 0);
INSERT INTO `sys_menu` VALUES (12, 2, '[0],[1],[2]', 1, '参数配置', '/home/sysconfig', 'el-icon-fa fa-cog', 6, 3, 0);
INSERT INTO `sys_menu` VALUES (13, 2, '[0],[1],[2]', 1, '数据字典', '/home/sysdict', 'el-icon-fa fa-list-ol', 7, 3, 0);

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org_pid` int(11) NOT NULL COMMENT '上级组织编码',
  `org_pids` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所有的父节点id',
  `is_leaf` tinyint(1) NOT NULL COMMENT '0:不是叶子节点，1:是叶子节点',
  `org_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织名',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `phone` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `level` int(11) NOT NULL COMMENT '组织层级',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统组织结构表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES (1, 0, '[0]', 0, 'DongTech', NULL, NULL, NULL, 1, 1, 0);
INSERT INTO `sys_org` VALUES (2, 1, '[0],[1]', 0, '北京分公司', '北京海淀区中关村', '13218765432', 'beijing21212@email.com', 1, 2, 0);
INSERT INTO `sys_org` VALUES (3, 2, '[0],[1],[2]', 1, '研发部', '北京海淀区中关村', '13218765422', 'hanxi@email.com', 1, 3, 0);
INSERT INTO `sys_org` VALUES (4, 2, '[0],[1],[2]', 1, '测试部', NULL, '', 'cesh@gmail.com', 2, 3, 0);
INSERT INTO `sys_org` VALUES (5, 1, '[0],[1]', 0, '上海分公司', '上海黄浦区', '13753287651', 'shanghaixx@email.com', 2, 2, 0);
INSERT INTO `sys_org` VALUES (6, 5, '[0],[1],[5]', 1, '运维部', '上海黄浦区', '13753287656', NULL, 1, 3, 0);
INSERT INTO `sys_org` VALUES (7, 5, '[0],[1],[5]', 1, '运维部二', '上海黄浦区', '13753287656', NULL, 2, 3, 0);
INSERT INTO `sys_org` VALUES (8, 5, '[0],[1],[5]', 1, '运维部三', '上海黄浦区', '13753287656', NULL, 3, 3, 0);
INSERT INTO `sys_org` VALUES (9, 5, '[0],[1],[5]', 1, '运维部四', '上海黄浦区', '13753287656', NULL, 4, 3, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '角色名称(汉字)',
  `role_desc` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '角色描述',
  `role_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '角色的英文code.如：ADMIN',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '角色顺序',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', '系统管理员', 'admin', 1, 0);
INSERT INTO `sys_role` VALUES (2, '普通用户', '普通用户', 'common', 2, 0);

-- ----------------------------
-- Table structure for sys_role_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_api`;
CREATE TABLE `sys_role_api`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `api_id` int(11) NOT NULL COMMENT '接口id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 359 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色接口权限关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_api
-- ----------------------------
INSERT INTO `sys_role_api` VALUES (6, 2, 4);
INSERT INTO `sys_role_api` VALUES (7, 2, 5);
INSERT INTO `sys_role_api` VALUES (315, 1, 1);
INSERT INTO `sys_role_api` VALUES (316, 1, 2);
INSERT INTO `sys_role_api` VALUES (317, 1, 3);
INSERT INTO `sys_role_api` VALUES (318, 1, 4);
INSERT INTO `sys_role_api` VALUES (319, 1, 5);
INSERT INTO `sys_role_api` VALUES (320, 1, 6);
INSERT INTO `sys_role_api` VALUES (321, 1, 7);
INSERT INTO `sys_role_api` VALUES (322, 1, 33);
INSERT INTO `sys_role_api` VALUES (323, 1, 8);
INSERT INTO `sys_role_api` VALUES (324, 1, 9);
INSERT INTO `sys_role_api` VALUES (325, 1, 10);
INSERT INTO `sys_role_api` VALUES (326, 1, 11);
INSERT INTO `sys_role_api` VALUES (327, 1, 12);
INSERT INTO `sys_role_api` VALUES (328, 1, 13);
INSERT INTO `sys_role_api` VALUES (329, 1, 14);
INSERT INTO `sys_role_api` VALUES (330, 1, 15);
INSERT INTO `sys_role_api` VALUES (331, 1, 16);
INSERT INTO `sys_role_api` VALUES (332, 1, 17);
INSERT INTO `sys_role_api` VALUES (333, 1, 18);
INSERT INTO `sys_role_api` VALUES (334, 1, 19);
INSERT INTO `sys_role_api` VALUES (335, 1, 20);
INSERT INTO `sys_role_api` VALUES (336, 1, 21);
INSERT INTO `sys_role_api` VALUES (337, 1, 22);
INSERT INTO `sys_role_api` VALUES (338, 1, 23);
INSERT INTO `sys_role_api` VALUES (339, 1, 24);
INSERT INTO `sys_role_api` VALUES (340, 1, 25);
INSERT INTO `sys_role_api` VALUES (341, 1, 26);
INSERT INTO `sys_role_api` VALUES (342, 1, 27);
INSERT INTO `sys_role_api` VALUES (343, 1, 28);
INSERT INTO `sys_role_api` VALUES (344, 1, 29);
INSERT INTO `sys_role_api` VALUES (345, 1, 30);
INSERT INTO `sys_role_api` VALUES (346, 1, 31);
INSERT INTO `sys_role_api` VALUES (347, 1, 32);
INSERT INTO `sys_role_api` VALUES (348, 1, 34);
INSERT INTO `sys_role_api` VALUES (349, 1, 35);
INSERT INTO `sys_role_api` VALUES (350, 1, 36);
INSERT INTO `sys_role_api` VALUES (351, 1, 37);
INSERT INTO `sys_role_api` VALUES (352, 1, 38);
INSERT INTO `sys_role_api` VALUES (353, 1, 39);
INSERT INTO `sys_role_api` VALUES (354, 1, 40);
INSERT INTO `sys_role_api` VALUES (355, 1, 41);
INSERT INTO `sys_role_api` VALUES (356, 1, 42);
INSERT INTO `sys_role_api` VALUES (357, 1, 43);
INSERT INTO `sys_role_api` VALUES (358, 1, 44);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT 0 COMMENT '角色id',
  `menu_id` int(11) NOT NULL DEFAULT 0 COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单权限关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (11, 2, 3);
INSERT INTO `sys_role_menu` VALUES (12, 2, 4);
INSERT INTO `sys_role_menu` VALUES (13, 2, 5);
INSERT INTO `sys_role_menu` VALUES (163, 1, 1);
INSERT INTO `sys_role_menu` VALUES (164, 1, 2);
INSERT INTO `sys_role_menu` VALUES (165, 1, 3);
INSERT INTO `sys_role_menu` VALUES (166, 1, 4);
INSERT INTO `sys_role_menu` VALUES (167, 1, 5);
INSERT INTO `sys_role_menu` VALUES (168, 1, 6);
INSERT INTO `sys_role_menu` VALUES (169, 1, 7);
INSERT INTO `sys_role_menu` VALUES (170, 1, 12);
INSERT INTO `sys_role_menu` VALUES (171, 1, 13);
INSERT INTO `sys_role_menu` VALUES (172, 1, 10);
INSERT INTO `sys_role_menu` VALUES (173, 1, 11);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '密码',
  `org_id` int(11) NOT NULL COMMENT '组织id',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0无效用户，1是有效用户',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'email',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '用户创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'yanfa1', '$2a$10$ThL6so8zVrOdWnr6ieZoV.1a.B3A48E8xTQheCdIEw9s1yuDhyPTq', 5, 1, '13214456789', '111@qq.com', '2020-10-10 15:11:18');
INSERT INTO `sys_user` VALUES (2, 'admin', '$2a$10$kYTCXTDccRfE0VEt0FlxdOt/0doFMkHkzazscUjauR0ke0pU.cn.y', 1, 1, '13756823456', 'Xx@163.com', '2020-02-27 18:37:47');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT 0 COMMENT '角色自增id',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户自增id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (2, 1, 2);
INSERT INTO `sys_user_role` VALUES (6, 2, 1);

SET FOREIGN_KEY_CHECKS = 1;
