package com.eland.dao;

import com.eland.pojo.model.TaskEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by yilunchen on 2017/8/26.
 */
public class TaskDAO {

    //搜尋未完成或失敗的複製任務清單
    public List<TaskEntity> selectUnfinishedTask() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskEntity failQuery = new TaskEntity();
        failQuery.setId(-1);
        List<TaskEntity> result = new LinkedList<TaskEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM TaskEntity where status is null or status!='DONE' order by actionFlag desc")
                    .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    //搜尋失敗的複製任務清單
    public void updateFailedTask(){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskEntity failQuery = new TaskEntity();
        failQuery.setId(-1);
        List<TaskEntity> result = new LinkedList<TaskEntity>();
        result.add(failQuery);
        try {
            session.createSQLQuery(
                    "UPDATE [opview_task].[dbo].[task] SET status=null, action_flag=null WHERE status='Fail'")
                    .executeUpdate();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
    }

    //自訂搜尋條件
    public List<TaskEntity> selectByUserDefined(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskEntity failQuery = new TaskEntity();
        failQuery.setId(-1);
        List<TaskEntity> result = new LinkedList<TaskEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM TaskEntity where " + condition)
                    .setMaxResults(100)
                    .list();
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
        return result;
    }

    //以index_name為搜尋條件
    public List<TaskEntity> selectByIndexName(String indexName, String orderField, String orderType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskEntity failQuery = new TaskEntity();
        failQuery.setId(-1);
        List<TaskEntity> result = new LinkedList<TaskEntity>();
        result.add(failQuery);
        try {
            indexName = indexName.replaceAll("%", "[%]");
            result = session.createQuery("FROM TaskEntity where indexName like " + "'%" + indexName + "%' " +
                    "order by " + orderField + " " + orderType)
                    .setMaxResults(100)
                    .list();
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
        return result;
    }

    //以machine_name為搜尋條件
    public List<TaskEntity> selectByMachineName(String machineName, String orderField, String orderType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskEntity failQuery = new TaskEntity();
        failQuery.setId(-1);
        List<TaskEntity> result = new LinkedList<TaskEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM TaskEntity where machineName = ? " +
                    "order by " + orderField + " " + orderType)
                    .setString(0, machineName)
                    .setMaxResults(100)
                    .list();
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
        return result;
    }


    //以action_flag為搜尋條件
    public List<TaskEntity> selectByActionFlag(String actionFlag, String orderField, String orderType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskEntity failQuery = new TaskEntity();
        failQuery.setId(-1);
        List<TaskEntity> result = new LinkedList<TaskEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM TaskEntity where actionFlag = ? " +
                    "order by " + orderField + " " + orderType)
                    .setString(0, actionFlag)
                    .setMaxResults(100)
                    .list();
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
        return result;
    }

}
