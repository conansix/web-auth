SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS auth_user;
CREATE TABLE auth_user (
  user_id  BIGINT AUTO_INCREMENT COMMENT '主键',
  username VARCHAR(100) NOT NULL COMMENT '用户名',
  password VARCHAR(100) NOT NULL COMMENT '该密码是经加盐值加密的，格式为password{username}。 比如用户名为user，密码为password，那么通过MD5进行加密的串为：password{user}',
  enabled  BOOLEAN COMMENT '是否有效',
  PRIMARY KEY pk_user_id(user_id),
  UNIQUE KEY uk_username(username)
) COMMENT '用户表' DEFAULT CHARSET utf8 ENGINE InnoDB;

DROP TABLE IF EXISTS auth_group;
CREATE TABLE auth_group (
  group_id   BIGINT AUTO_INCREMENT,
  group_name VARCHAR(40) NOT NULL COMMENT '用户组名称',
  group_desc VARCHAR(100) COMMENT '用户组描述',
  enabled    BOOLEAN COMMENT '是否有效',
  PRIMARY KEY pk_group_id(group_id),
  UNIQUE KEY uk_group_name (group_name)
) COMMENT '用户组表' DEFAULT CHARSET utf8 ENGINE InnoDB;

DROP TABLE IF EXISTS auth_authority;
CREATE TABLE auth_authority (
  authority_id   BIGINT AUTO_INCREMENT COMMENT '权限编号',
  authority      VARCHAR(50) UNIQUE NOT NULL COMMENT '权限',
  authority_desc VARCHAR(100) COMMENT '权限描述',
  enabled        BOOLEAN COMMENT '是否有效',
  PRIMARY KEY pk_authority_id(authority_id),
  UNIQUE KEY uk_authority (authority)
) COMMENT '权限表' DEFAULT CHARSET utf8 ENGINE InnoDB;

DROP TABLE IF EXISTS auth_resource;
CREATE TABLE auth_resource (
  resource_id   BIGINT AUTO_INCREMENT,
  resource_name VARCHAR(100) COMMENT '资源名',
  resource_desc VARCHAR(100) COMMENT '资源描述',
  resource_type VARCHAR(40) COMMENT '资源类型',
  resource      VARCHAR(200) COMMENT '资源地址',
  priority      INT COMMENT '优先次序',
  enabled       BOOLEAN COMMENT '是否有效',
  PRIMARY KEY pk_resource_id (resource_id),
  UNIQUE KEY uk_resource (resource)
) COMMENT '资源表' DEFAULT CHARSET utf8 ENGINE InnoDB;

DROP TABLE IF EXISTS auth_user_group;
CREATE TABLE auth_user_group (
  id       BIGINT AUTO_INCREMENT,
  user_id  BIGINT NOT NULL,
  group_id BIGINT NOT NULL,
  PRIMARY KEY pk_auth_user_group_id(id),
  FOREIGN KEY fk_user_id_4_group(user_id) REFERENCES auth_user (user_id),
  FOREIGN KEY fk_group_id_4_user(group_id) REFERENCES auth_group (group_id)
) COMMENT '用户角色表' DEFAULT CHARSET utf8 ENGINE InnoDB;

DROP TABLE IF EXISTS auth_authority_resource;
CREATE TABLE auth_authority_resource (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  authority_id BIGINT NOT NULL COMMENT '权限编号',
  resource_id  BIGINT NOT NULL COMMENT '资源编号',
  FOREIGN KEY fk_authority_id_4_resource(authority_id) REFERENCES auth_authority (authority_id),
  FOREIGN KEY fk_resource_id_4_authority(resource_id) REFERENCES auth_resource (resource_id)
) COMMENT '权限资源表' DEFAULT CHARSET utf8 ENGINE InnoDB;

DROP TABLE IF EXISTS auth_group_authority;
CREATE TABLE auth_group_authority (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  group_id     BIGINT COMMENT '用户组编号',
  authority_id BIGINT COMMENT '权限编号',
  FOREIGN KEY fk_group_id_4_authority(group_id) REFERENCES auth_group (group_id),
  FOREIGN KEY fk_authority_id_4_group(authority_id) REFERENCES auth_authority (authority_id)
) COMMENT '角色权限表' DEFAULT CHARSET utf8 ENGINE InnoDB;

DROP TABLE IF EXISTS persistent_logins;
CREATE TABLE persistent_logins (
  series    VARCHAR(64) PRIMARY KEY,
  username  VARCHAR(64) NOT NULL,
  token     VARCHAR(64) NOT NULL,
  last_used TIMESTAMP   NOT NULL
) COMMENT 'Remember-Me' DEFAULT CHARSET utf8 ENGINE InnoDB;

  SET FOREIGN_KEY_CHECKS = 1;