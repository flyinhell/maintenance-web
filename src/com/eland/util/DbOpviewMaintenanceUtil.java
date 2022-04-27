package com.eland.util;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;


/**
 * Created by johnnyhuang on 2018/3/7.
 */
public class DbOpviewMaintenanceUtil {
    private static final SessionFactory sessionFactory;
    private static final SessionFactory sessionFactory127;

    static {
        sessionFactory = new Configuration().configure("opviewTask_hibernate.cfg.xml").buildSessionFactory();
        sessionFactory127 = new Configuration().configure("wh_query_hibernate.cfg.xml").buildSessionFactory();
    }

    public static Session getSession() throws HibernateException {
        return sessionFactory.openSession();
    }

    public static Session getSession127() throws HibernateException {
        return sessionFactory127.openSession();
    }

    public static void close() throws HibernateException {
        sessionFactory.close();
    }

    public static void close127() throws HibernateException {
        sessionFactory127.close();
    }

}

