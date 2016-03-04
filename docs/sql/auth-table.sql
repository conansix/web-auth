DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user (
  user_id    BIGINT PRIMARY KEY AUTO_INCREMENT,
  account    VARCHAR(30)  NOT NULL
  COMMENT '账户',
  username   VARCHAR(100) NOT NULL
  COMMENT '用户名',
  password   VARCHAR(100) NOT NULL
  COMMENT '该密码是经加盐值加密的，格式为password{username}。 比如用户的密码为password，用户名为user，那么通过MD5进行加密的串为：password{user}',
  user_desc  VARCHAR(256) COMMENT '用户描述',
  enabled    BOOLEAN COMMENT '是否有效',
  is_sys     BOOLEAN COMMENT '是否是超级用户',
  dept       VARCHAR(20) COMMENT '所在单位',
  duty       VARCHAR(10) COMMENT '经理或主任',
  sub_system VARCHAR(30) COMMENT '该用户所负责的各子系统，可多个，中间用逗号分隔。(目前暂未用，作为保留字段)'
)
  COMMENT '用户表'
  DEFAULT CHARSET utf8
  ENGINE InnoDB;

DROP TABLE IF EXISTS sys_role;
CREATE TABLE sys_role (
  role_id   BIGINT PRIMARY KEY AUTO_INCREMENT,
  role_name VARCHAR(40) NOT NULL
  COMMENT '角色名称',
  role_desc VARCHAR(100) COMMENT '角色描述',
  enabled   BOOLEAN COMMENT '是否有效',
  is_sys    BOOLEAN COMMENT '',
  module    VARCHAR(4) COMMENT '所属的子系统，比如平台里面包括10个系统，分别为成本、作业、集输等。'
)
  COMMENT '角色表'
  DEFAULT CHARSET utf8
  ENGINE InnoDB;

DROP TABLE IF EXISTS sys_authority;
CREATE TABLE sys_authority (
  authority_id   BIGINT PRIMARY KEY AUTO_INCREMENT
  COMMENT '权限编号',
  authority_name VARCHAR(50) UNIQUE NOT NULL
  COMMENT '权限',
  authority_desc VARCHAR(100) COMMENT '权限描述',
  enabled        BOOLEAN COMMENT '是否有效',
  is_sys         BOOLEAN COMMENT '',
  module         VARCHAR(4) COMMENT '所属的子系统，比如平台里面包括10个系统，分别为成本、作业、集输等。'
)
  COMMENT '权限表'
  DEFAULT CHARSET utf8
  ENGINE InnoDB;

DROP TABLE IF EXISTS sys_resource;
CREATE TABLE sys_resource (
  resource_id   BIGINT PRIMARY KEY AUTO_INCREMENT,
  resource_name VARCHAR(100) COMMENT '资源名',
  resource_desc VARCHAR(100) COMMENT '资源描述',
  resource_type VARCHAR(40) COMMENT '资源类型',
  resource      VARCHAR(200) COMMENT '资源地址',
  priority      INT COMMENT '优先次序：暂留',
  enabled       BOOLEAN COMMENT '是否有效',
  is_sys        BOOLEAN COMMENT '',
  module        VARCHAR(4) COMMENT '所属的子系统，比如平台里面包括10个系统，分别为成本、作业、集输等。（暂留）'
)
  COMMENT '资源表'
  DEFAULT CHARSET utf8
  ENGINE InnoDB;

DROP TABLE IF EXISTS sys_user_role;
CREATE TABLE sys_user_role (
  id      BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL,
  enabled BOOLEAN,
  CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES sys_user (user_id),
  CONSTRAINT fk_role_id_4_user FOREIGN KEY (role_id) REFERENCES sys_role (role_id)
)
  COMMENT '用户角色表'
  DEFAULT CHARSET utf8
  ENGINE InnoDB;

DROP TABLE IF EXISTS sys_authority_resource;
CREATE TABLE sys_authority_resource (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  authority_id BIGINT NOT NULL
  COMMENT '权限编号',
  resource_id  BIGINT NOT NULL
  COMMENT '资源编号',
  enabled      BOOLEAN            DEFAULT TRUE
  COMMENT '是否有效',
  CONSTRAINT fk_authority_id_4_resource FOREIGN KEY (authority_id) REFERENCES sys_authority (authority_id),
  CONSTRAINT fk_resource_id FOREIGN KEY (resource_id) REFERENCES sys_resource (resource_id)
)
  COMMENT '权限资源表'
  DEFAULT CHARSET utf8
  ENGINE InnoDB;

DROP TABLE IF EXISTS sys_role_authority;
CREATE TABLE sys_role_authority (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  role_id      BIGINT COMMENT '用户组编号',
  authority_id BIGINT COMMENT '权限编号',
  enabled      BOOLEAN            DEFAULT TRUE
  COMMENT '是否有效',
  CONSTRAINT fk_role_id_4_authority FOREIGN KEY (role_id) REFERENCES sys_role (role_id),
  CONSTRAINT fk_authority_id FOREIGN KEY (authority_id) REFERENCES sys_authority (authority_id)
)
  COMMENT '角色权限表'
  DEFAULT CHARSET utf8
  ENGINE InnoDB;