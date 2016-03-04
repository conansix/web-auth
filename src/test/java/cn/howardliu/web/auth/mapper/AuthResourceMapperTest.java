package cn.howardliu.web.auth.mapper;

import cn.howardliu.web.auth.pojo.AuthResourcePojo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:spring.xml"})
public class AuthResourceMapperTest {
    private static final Logger logger = LoggerFactory.getLogger(AuthResourceMapper.class);
    @Autowired
    private AuthResourceMapper authResourceMapper;

    @Test
    public void testGetResourceById() throws Exception {
        List<AuthResourcePojo> resources = authResourceMapper.listResourcesByAuthorityId("1");
        logger.info(resources.toString());
    }
}