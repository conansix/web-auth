INSERT INTO auth.auth_authority (authority_id, authority, authority_desc, enabled) VALUES (1, 'ROLE_ADMIN', '管理员', 1);

INSERT INTO auth.auth_group (group_id, group_name, group_desc, enabled) VALUES (1, 'ADMIN', '管理员', 1);

INSERT INTO auth.auth_user (user_id, username, password, enabled) VALUES (1, 'admin', 'ceb4f32325eda6142bd65215f4c0f371', 1);

INSERT INTO auth.auth_resource (resource_id, resource_name, resource_desc, resource_type, resource, priority, enabled) VALUES (1, 'index', 'index', NULL, '/index.html', 0, 1);

INSERT INTO auth.auth_group_authority (id, group_id, authority_id) VALUES (1, 1, 1);

INSERT INTO auth.auth_user_group (id, user_id, group_id) VALUES (1, 1, 1);

INSERT INTO auth.auth_authority_resource (id, authority_id, resource_id) VALUES (1, 1, 1);