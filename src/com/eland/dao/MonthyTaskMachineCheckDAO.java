package com.eland.dao;

import com.eland.pojo.model.MonthyTaskMachineCheckEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by kueihenglu on 2018/8/23.
 */
public class MonthyTaskMachineCheckDAO {
    public List<MonthyTaskMachineCheckEntity> selectMonthyTaskMachineCheck() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyTaskMachineCheckEntity failQuery = new MonthyTaskMachineCheckEntity();
        List<MonthyTaskMachineCheckEntity> result = new LinkedList<MonthyTaskMachineCheckEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM MonthyTaskMachineCheckEntity order by machineName asc").list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    public List<MonthyTaskMachineCheckEntity> selectMonthyTaskMachineCheck(String machineName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyTaskMachineCheckEntity failQuery = new MonthyTaskMachineCheckEntity();
        List<MonthyTaskMachineCheckEntity> result = new LinkedList<MonthyTaskMachineCheckEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM MonthyTaskMachineCheckEntity where machineName =?")
                    .setString(0, machineName)
                    .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    public void insertMonthyTaskMachineCheck(String machineName) {
        //取得現在時間
        SimpleDateFormat monthDateFormat = new SimpleDateFormat("yyyyMM");
        Calendar today = Calendar.getInstance();
        String yearMonth = monthDateFormat.format(today.getTime());

        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        String sql = "INSERT INTO [opview_task].[dbo].[monthy_task_machine_check] VALUES(?,'New','New',GETDATE(),?)";
        try {
            session.createSQLQuery(sql)
                    .setString(0, machineName)
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

    public boolean deleteMonthyTaskMachineCheck(String machineName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();

        List<MonthyTaskMachineCheckEntity> list = selectMonthyTaskMachineCheck(machineName);
        Boolean delete = false;
        try {
            for (MonthyTaskMachineCheckEntity monthyTaskMachineCheckEntity : list) {
                session.delete(monthyTaskMachineCheckEntity);
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
