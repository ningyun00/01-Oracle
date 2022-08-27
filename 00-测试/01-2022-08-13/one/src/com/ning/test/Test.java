package com.ning.test;

import com.ning.dao.EntityDao;
import com.ning.entity.MyTest;

import java.io.InputStream;
import java.util.List;
import java.util.Properties;

/**
 * @author 寜
 * @date 2022-08-13
 * @time 下午 06:08
 */
public class Test {
    public static void main(String[] args) {
        for (int i = 1; i <=100 ; i++) {
            if  (1%i==0&&i%i==0){
                System.out.println(i);
            }
        }
    }
/*    private static EntityDao myTestDao = new EntityDao();
    private static Properties properties = new Properties();

    public static void main(String[] args) throws Exception {
        InputStream resourceAsStream = Test.class.getClassLoader().getResourceAsStream("test.properties");
        properties.load(resourceAsStream);
        Class myTest = Class.forName(properties.getProperty("className"));
        MyTest myTestAdd = new MyTest(null, "陆号", "六类", 6f);
        if (new EntityDao().add(myTestAdd) > 0) {
            System.out.println("成功");
        }
        List<MyTest> select = myTestDao.select(myTest);
        System.out.println(select);
    }*/
}
