SET UNIQUE_CHECKS = 0;

DELETE FROM auth_user;
DELETE FROM auth_group;
DELETE FROM auth_authority;
DELETE FROM auth_resource;
DELETE FROM auth_user_group;
DELETE FROM auth_group_authority;
DELETE FROM auth_authority_resource;

INSERT INTO auth.auth_user (user_id, username, password, enabled) VALUES (1, 'admin', 'ceb4f32325eda6142bd65215f4c0f371', 1);

INSERT INTO auth.auth_group (group_id, group_name, group_desc, enabled) VALUES (1, 'ADMIN', '管理员', 1);
INSERT INTO auth.auth_group (group_id, group_name, group_desc, enabled) VALUES (2, 'USER', '用户', 1);
INSERT INTO auth.auth_group (group_id, group_name, group_desc, enabled) VALUES (3, 'ANONYMOUS', '匿名', 1);

INSERT INTO auth.auth_authority (authority_id, authority, authority_desc, enabled) VALUES (1, 'ROLE_ADMIN', '管理员', 1);
INSERT INTO auth.auth_authority (authority_id, authority, authority_desc, enabled) VALUES (2, 'ROLE_USER', '用户', 1);
INSERT INTO auth.auth_authority (authority_id, authority, authority_desc, enabled) VALUES (3, 'ROLE_ANONYMOUS', '游客', 1);

INSERT INTO auth.auth_resource (resource_id, resource_name, resource_desc, resource_type, resource, priority, enabled) VALUES (1, 'index', '首页', null, '/index.html', 0, 1);
INSERT INTO auth.auth_resource (resource_id, resource_name, resource_desc, resource_type, resource, priority, enabled) VALUES (2, 'userAuthorities', '用户权限树', null, '/userAuthorities.html', 1, 1);
INSERT INTO auth.auth_resource (resource_id, resource_name, resource_desc, resource_type, resource, priority, enabled) VALUES (3, '/user/authTree', '用户权限树数据', null, '/user/authTree.json', 2, 1);

INSERT INTO auth.auth_user_group (id, user_id, group_id) VALUES (1, 1, 1);
INSERT INTO auth.auth_user_group (id, user_id, group_id) VALUES (2, 1, 2);

INSERT INTO auth.auth_group_authority (id, group_id, authority_id) VALUES (1, 1, 1);
INSERT INTO auth.auth_group_authority (id, group_id, authority_id) VALUES (2, 1, 2);
INSERT INTO auth.auth_group_authority (id, group_id, authority_id) VALUES (3, 1, 3);
INSERT INTO auth.auth_group_authority (id, group_id, authority_id) VALUES (4, 2, 2);
INSERT INTO auth.auth_group_authority (id, group_id, authority_id) VALUES (5, 2, 3);
INSERT INTO auth.auth_group_authority (id, group_id, authority_id) VALUES (6, 3, 3);

INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (1, 1, 1);
INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (2, 1, 2);
INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (3, 1, 3);
INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (4, 2, 1);
INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (5, 2, 2);
INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (6, 2, 3);
INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (7, 3, 1);

SET UNIQUE_CHECKS = 1;