package cn.howardliu.web.auth.mapper;

import cn.howardliu.web.auth.pojo.AuthGroupPojo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring.xml")
public class AuthGroupMapperTest {
    private static final Logger logger = LoggerFactory.getLogger(AuthAuthorityMapperTest.class);
    @Autowired
    private AuthGroupMapper authGroupMapper;

    @Test
    public void testListGroupsByUserId() throws Exception {
        List<AuthGroupPojo> groups = authGroupMapper.listGroupsByUserId("1");
        logger.info(groups.toString());
    }
}