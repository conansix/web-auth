SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM sys_user;
DELETE FROM sys_role;
DELETE FROM sys_authority;
DELETE FROM sys_resource;
DELETE FROM sys_user_role;
DELETE FROM sys_role_authority;
DELETE FROM sys_authority_resource;

INSERT INTO sys_user (user_id, account, username, password, user_desc, enabled, is_sys, dept, duty, sub_system)
VALUES
  ('1304494573750', 'liuxh', 'liuxh', 'c7d3f4c857bc8c145d6e5d40c1bf23d9', NULL, 1, 0, '10011001', NULL, '01'),
  ('1304490737406', 'liuxh', 'liuxh', 'c7d3f4c857bc8c145d6e5d40c1bf23d9', NULL, 1, 0, '10011001', NULL, '01'),
  ('1304574079546', 'ddd', 'ddd', '0a4f6a961276619f7f91356bcba5a746', NULL, 0, 0, NULL, NULL, '01'),
  ('1304573363921', 'liuxh', '沉潜飞动', '09eb37d219cfa835db40e5ab587f7082', '普通仅登录到欢迎界面！', 0, 0, '1001', NULL, '01'),
  ('1304573484515', 'lll', 'lll', '47acedc22cef8c3762c21a435e262d67', NULL, 1, 0, '1001', NULL, '01'),
  ('1304573484516', 'admin', '系统管理员', 'ceb4f32325eda6142bd65215f4c0f371', '超级系统管理员', 1, 1, '1001', NULL, '01'),
  ('1304573484517', 'user', '普通用户', '47a733d60998c719cf3526ae7d106d13', '普通用户', 1, 0, '1001', NULL, '01'),
  ('1304573484518', 'sysUser', '系统设置维护', '8f0295328c34f8eedc2362e9f4a10b7e', '系统设置用户', 1, 0, '1001', NULL, '01'),
  ('1304573484519', 'liuxh', '沉潜飞动', 'c7d3f4c857bc8c145d6e5d40c1bf23d9', '普通仅登录到欢迎界面！', 1, 0, '1001', NULL, '01'),
  ('1304566319625', 'liuxh5', 'lx5', '1abe40ed6d0da1c834586e8ecef61fe7', NULL, 0, 0, '10011001', NULL, '01');

INSERT INTO sys_role (role_id, role_name, role_desc, enabled, is_sys, module)
VALUES
  ('1303463518765', 'ROLE_dd1', 'dd1', 1, 0, '01'),
  ('1303463949640', 'ROLE_rr1', 'rr1', 1, 0, '02'),
  ('1303463949641', 'ROLE_PLATFORMADMIN', '可管理整个平台的用户、单位设置。', 1, 1, '01'),
  ('1303463949642', 'ROLE_USER', '普通用户', 1, 0, '01'),
  ('1303463949643', '1303463949646TOWELCOME', '仅登录到欢迎界面！', 1, 0, '01'),
  ('1303463949644', 'ROLE_SYSADMIN', '可管理本系统的用户、单位设置。', 1, 0, '01'),
  ('1303463949645', '1303463949645', '作业子系统的角色（试验）', 1, 0, '02'),
  ('1303463949646', '1303463949646', '系统登录', 1, 0, '01');

INSERT INTO sys_authority (authority_id, authority_name, authority_desc, enabled, is_sys, module)
VALUES
  ('1303910437484', 'AUTH_xxx', 'xxx', NULL, NULL, '01'),
  ('1303463949647', 'AUTH_LOGIN', '登录', 1, 0, '01'),
  ('1303463949648', 'AUTH_AFTERLOGINWELCOME', '登录后欢迎界面', 1, 0, '01'),
  ('1303463949649', 'AUTH_XTSZ_DEPT', '单位设置', 1, 0, '01'),
  ('1303463949610', 'AUTH_XTSZ_USER', '用户设置、横向查询', 1, 0, '01'),
  ('1303463949611', 'AUTH_NODE_MGR', '节点管理、纵向查询', 1, 0, '01');

INSERT INTO sys_resource (resource_id, resource_name, resource_desc, resource_type, resource, priority, enabled, is_sys, module)
VALUES
  ('1303909883031', 'ff', 'ff', 'action', 'b.jsp', NULL, 1, 0, NULL),
  ('1303909847687', 'ff1', 'ff1', 'action', 'b.jsp', NULL, 1, 0, NULL),
  ('1303909847688', 'node_mgr', '节点管理', 'url', '/*/*/Tree.jsp', NULL, 1, 0, NULL),
  ('1303909847689', 'login', '登录', 'url', '/login.jsp', NULL, 1, 0, NULL),
  ('1303909847690', 'index', '登录后欢迎页面', 'url', '/index.jsp', NULL, 1, 0, NULL),
  ('1303909847691', 'resources_mgr', '资源管理', 'action', '/managerResource', NULL, 1, 0, NULL),
  ('1303909847692', 'horizontal_qry', '横向查询', 'action', '/horizontalQuery', NULL, 1, 0, NULL),
  ('1303909847693', 'vertical_qry', '纵向查询', 'action', '/verticalQuery', NULL, 1, 0, NULL),
  ('1303909847694', 'dep_mgr', '单位管理', 'action', '/UnitsManager', NULL, 1, 0, NULL),
  ('1303909847695', 'user_mgr', '用户管理', 'action', '/managerUser', NULL, 1, 0, NULL),
  ('1303909847696', 'authority_mgr', '权限管理', 'action', '/managerAuthority', NULL, 1, 0, NULL),
  ('1303909847697', 'role_mgr', '角色管理', 'action', '/managerRole', NULL, NULL, NULL, NULL);

INSERT INTO sys_authority_RESOURCE (ID, AUTHORITY_ID, RESOURCE_ID, ENABLED)
VALUES
  (1, '1303463949648', '1303909847690', 1),
  (2, '1303463949647', '1303909847689', 1),
  (3, '1303463949611', '1303909847688', 1),
  (4, '1303463949649', '1303909847694', 1),
  (5, '1303463949610', '1303909847695', 1),
  (7, '1303463949610', '1303909847692', 1),
  (8, '1303463949649', '1303909847693', 1),
  (12, '1303463949610', '1303909847697', 1),
  (10, '1303463949610', '1303909847691', 1),
  (11, '1303463949610', '1303909847696', 1);

INSERT INTO sys_role_authority (id, role_id, authority_id, enabled)
VALUES
  (1, '1303463949643', '1303463949648', 1),
  (2, '1303463949641', '1303463949648', 1),
  (3, '1303463949641', '1303463949647', 1),
  (4, '1303463949641', '1303463949611', 1),
  (5, '1303463949641', '1303463949649', 1),
  (6, '1303463949641', '1303463949610', 1),
  (7, '1303463949644', '1303463949649', 1),
  (8, '1303463949644', '1303463949610', 1),
  (9, '1303463949642', '1303463949647', 1),
  (10, '1303463949643', '1303463949647', 1),
  (11, '1303463949642', '1303463949648', 1),
  (12, '1303463949640', '1303463949647', 1),
  (13, '1303463949645', '1303463949647', 1),
  (14, '1303463949645', '1303463949648', 1),
  (15, '1303463949645', '1303463949649', 1),
  (16, '1303463949645', '1303463949610', 1),
  (17, '1303463949645', '1303463949611', 1),
  (18, '1303463949646', '1303463949647', 1);

INSERT INTO sys_user_role (id, user_id, role_id, enabled)
VALUES
  (1, '1304573484516', '1303463949641', 1),
  (2, '1304573484518', '1303463949644', 1),
  (3, '1304573484517', '1303463949642', 1),
  (4, '1304573484519', '1303463949643', 1),
  (5, '1304573484515', '1303463518765', NULL);

SET FOREIGN_KEY_CHECKS = 1;