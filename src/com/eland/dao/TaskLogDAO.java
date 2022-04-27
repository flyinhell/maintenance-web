package com.eland.dao;

import com.eland.pojo.model.TaskLogEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/3/19.
 */
public class TaskLogDAO {
    //自訂搜尋條件
    public List<TaskLogEntity> selectByUserDefined(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskLogEntity failQuery = new TaskLogEntity();
        failQuery.setIndexName("Fail Query");
        List<TaskLogEntity> result = new LinkedList<TaskLogEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM TaskLogEntity where " + condition)
                    .setMaxResults(100)
                    .list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    //查詢最近複製失敗的任務
    public List<TaskLogEntity> selectFailTaskLog(int num) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskLogEntity failQuery = new TaskLogEntity();
        failQuery.setIndexName("Fail Query");
        List<TaskLogEntity> result = new LinkedList<TaskLogEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM TaskLogEntity where status !='DONE' order by taskStartTime desc ")
                    .setMaxResults(num)
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
    public List<TaskLogEntity> selectByIndexName(String indexName,
                                                 String taskStartTimeRange1,
                                                 String taskStartTimeRange2,
                                                 String sortField,
                                                 String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskLogEntity failQuery = new TaskLogEntity();
        failQuery.setIndexName("Fail Query");
        List<TaskLogEntity> result = new LinkedList<TaskLogEntity>();
        result.add(failQuery);
        System.out.println(indexName);
        System.out.println(taskStartTimeRange1);
        System.out.println(taskStartTimeRange2);
        System.out.println(sortField);
        System.out.println(sortType);
        try {
            indexName = indexName.replaceAll("%", "[%]");
            result = session.createQuery("FROM TaskLogEntity where indexName like ? " +
                    "and taskStartTime >=? " +
                    "and taskStartTime <? " +
                    "order by " + sortField + " " + sortType)
                    .setString(0, "%" + indexName + "%")
                    .setString(1, taskStartTimeRange1)
                    .setString(2, taskStartTimeRange2)
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
    public List<TaskLogEntity> selectByActionFlag(String actionFlag,
                                                  String taskStartTimeRange1,
                                                  String taskStartTimeRange2,
                                                  String sortField,
                                                  String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskLogEntity failQuery = new TaskLogEntity();
        failQuery.setIndexName("Fail Query");
        List<TaskLogEntity> result = new LinkedList<TaskLogEntity>();
        result.add(failQuery);
        System.out.println(actionFlag);
        System.out.println(taskStartTimeRange1);
        System.out.println(taskStartTimeRange2);
        System.out.println(sortField);
        System.out.println(sortType);
        try {
            result = session.createQuery("FROM TaskLogEntity where actionFlag = ? " +
                    "and taskStartTime >=? " +
                    "and taskStartTime <? " +
                    "order by " + sortField + " " + sortType)
                    .setString(0, actionFlag)
                    .setString(1, taskStartTimeRange1)
                    .setString(2, taskStartTimeRange2)
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

    //以target_path為搜尋條件
    public List<TaskLogEntity> selectByTargetPath(String targetPath,
                                                  String machineIP,
                                                  String taskStartTimeRange1,
                                                  String taskStartTimeRange2,
                                                  String sortField,
                                                  String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        TaskLogEntity failQuery = new TaskLogEntity();
        failQuery.setIndexName("Fail Query");
        List<TaskLogEntity> result = new LinkedList<TaskLogEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM TaskLogEntity where (targetPath like ? or targetPath like ?)" +
                    "and taskStartTime >=? " +
                    "and taskStartTime <? " +
                    "order by " + sortField + " " + sortType)
                    .setString(0, "%" + targetPath + "%")
                    .setString(1, "%" + machineIP + "%")
                    .setString(2, taskStartTimeRange1)
                    .setString(3, taskStartTimeRange2)
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
