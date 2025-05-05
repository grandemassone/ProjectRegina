package model;

import org.apache.tomcat.jdbc.pool.PoolProperties;
import org.apache.tomcat.jdbc.pool.DataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.TimeZone;


public class ConPool {
    private static DataSource datasource;

    static {
        PoolProperties p = new PoolProperties();
        p.setUrl("jdbc:mysql://localhost:3306/db_regina?serverTimezone=" + TimeZone.getDefault().getID());
        p.setDriverClassName("com.mysql.cj.jdbc.Driver");
        p.setUsername("root");
        p.setPassword("solesole2");
        p.setInitialSize(10);
        p.setMinIdle(10);
        p.setMaxActive(100);
        p.setMaxWait(10000);
        p.setRemoveAbandoned(true);
        p.setRemoveAbandonedTimeout(60);
        p.setTestOnBorrow(true);
        p.setValidationQuery("SELECT 1");

        datasource = new DataSource();
        datasource.setPoolProperties(p);
    }

    public static Connection getConnection() throws SQLException {
        return datasource.getConnection();
    }
}
