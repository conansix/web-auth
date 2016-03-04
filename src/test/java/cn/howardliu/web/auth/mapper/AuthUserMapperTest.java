package cn.howardliu.web.auth.mapper;

import cn.howardliu.web.auth.pojo.AuthUserPojo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring.xml")
public class AuthUserMapperTest {
    private static final Logger logger = LoggerFactory.getLogger(AuthAuthorityMapperTest.class);
    @Autowired
    private AuthUserMapper authUserMapper;

    @Test
    public void testGetUserById() throws Exception {
        AuthUserPojo authUserPojo = authUserMapper.getUserById("1");
        logger.info(authUserPojo.toString());
    }
}