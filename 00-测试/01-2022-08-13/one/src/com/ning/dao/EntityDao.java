package com.ning.dao;

import com.ning.entity.MyTest;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EntityDao {
    private static Connection connection = null;
    private static PreparedStatement preparedStatement = null;
    private static ResultSet resultSet = null;
    private static BaseDao baseDao = new BaseDao();
    private static String sql = null;
    private static int row = 0;

    public List select(Class c) {
        List list = new ArrayList();
        try {
            connection = baseDao.getConnection();
            sql = "SELECT * FROM " + c.getSimpleName();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Object object = c.newInstance();
                for (Field field : c.getDeclaredFields()) {
                    field.setAccessible(true);
                    Object o = resultSet.getObject(field.getName());
                    field.set(object, o);
                }
                list.add(object);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            baseDao.close(resultSet, preparedStatement, connection);
        }
        return list;
    }

    public int add(Object object) {
        row = 0;
        try {
            connection = baseDao.getConnection();
            Class c = object.getClass();
            StringBuffer sql = new StringBuffer("INSERT INTO " + c.getSimpleName() + " VALUES(");
            for (Field field : c.getDeclaredFields()) {
                field.setAccessible(true);
                if (field.get(object) == null) {
                    sql.append(field.get(object) + ",");
                }
                if (field.get(object) != null) {
                    sql.append("'" + field.get(object) + "',");
                }
            }
            sql.delete(sql.lastIndexOf(","), sql.length()).append(")");
            preparedStatement = connection.prepareStatement(sql.toString());
            row = preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            baseDao.close(null, preparedStatement, connection);
        }
        return row;
    }

    public int delete(Object o) {
        row = 0;
        try {
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            baseDao.close(null, preparedStatement, connection);
        }
        return row;
    }
}
