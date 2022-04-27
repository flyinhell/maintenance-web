package com.eland.dao;

import com.eland.pojo.model.MonthyTaskCheckEntity;
import com.eland.pojo.model.MonthyTaskConfigEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by kueihenglu on 2018/8/23.
 */
public class MonthyTaskCheckDAO {

    public List<MonthyTaskCheckEntity> selectMonthyTaskCheck() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyTaskCheckEntity failQuery = new MonthyTaskCheckEntity();
        List<MonthyTaskCheckEntity> result = new LinkedList<MonthyTaskCheckEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM MonthyTaskCheckEntity order by indexName asc").list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    public List<MonthyTaskCheckEntity> selectMonthyTaskCheck(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyTaskCheckEntity failQuery = new MonthyTaskCheckEntity();
        List<MonthyTaskCheckEntity> result = new LinkedList<MonthyTaskCheckEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM MonthyTaskCheckEntity where indexName =?")
                    .setString(0, indexName)
                    .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    public void insertMonthyTaskCheck(String indexName) {
        //取得現在時間
        SimpleDateFormat monthDateFormat = new SimpleDateFormat("yyyyMM");
        Calendar today = Calendar.getInstance();
        String yearMonth = monthDateFormat.format(today.getTime());

        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        String sql = "INSERT INTO [opview_task].[dbo].[monthy_task_check] VALUES(?,'New','New','New','New','New','New',GETDATE(),?)";
        try {
            session.createSQLQuery(sql)
                    .setString(0, indexName)
                    .setString(1, yearMonth)
                    .executeUpdate();
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            session.close();
        }

    }

    public boolean deleteMonthyTaskConfig(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();

        List<MonthyTaskCheckEntity> list = selectMonthyTaskCheck(indexName);
        Boolean delete = false;
        try {
            for (MonthyTaskCheckEntity monthyTaskCheckEntity : list) {
                session.delete(monthyTaskCheckEntity);
            }

            tx.commit();
            delete = true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return delete;
    }


}
