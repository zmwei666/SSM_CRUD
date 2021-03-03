package com.theory.dao;

import com.theory.bean.Department;
import com.theory.bean.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层
 * 推荐Spring的项目就可以使用spring的单元测试，可以自动注入我们需要的主键
 * @ContextConfiguration 指定spring配置文件的位置
 * @RunWith 使用spring的单元测试
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class DaoTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void test1() {
        System.out.println(departmentMapper);

        // 插入两个部门
        Department department1 = new Department(null, "开发部");
        Department department2 = new Department(null, "测试部");
        departmentMapper.insertSelective(department1);
        departmentMapper.insertSelective(department2);

    }

    @Test
    public void test2() {
        // 生成员工数据，测试员工插入
        Employee employee1 = new Employee(null, "Jerry", "M", "Jerry@qq.com", 1);
        employeeMapper.insertSelective(employee1);
    }

    @Test
    public void test3() {
        // 批量插入多个员工，批量，使用可以执行批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
        }
        System.out.println("批量完成");
    }

}
