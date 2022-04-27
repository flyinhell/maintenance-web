package com.eland.dao;

import com.eland.pojo.model.CustomIndexInformationEntity;
import com.eland.pojo.model.IndexRollbackTaskEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.*;

import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/4/13.
 */
public class RollbackTaskDAO {
    //查詢全部
    public List<IndexRollbackTaskEntity> selectIndexRollbackTask() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexRollbackTaskEntity failQuery = new IndexRollbackTaskEntity();
        failQuery.setId(-1);
        List<IndexRollbackTaskEntity> result = new LinkedList<IndexRollbackTaskEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM IndexRollbackTaskEntity order by createTime desc ")
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


    //刪除指定客製排程
    public boolean deleteCustomIndexInformation(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<IndexRollbackTaskEntity> list = selectIndexRollbackTaskById(id);
        Boolean delete = false;
        try {
            for (IndexRollbackTaskEntity indexRollbackTaskEntity : list) {
                session.delete(indexRollbackTaskEntity);
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


    //刪除指定客製排程
    public boolean deleteIndexRollbackTask(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<IndexRollbackTaskEntity> list = selectIndexRollbackTaskByIndexName(indexName);
        Boolean delete = false;
        try {
            for (IndexRollbackTaskEntity indexRollbackTaskEntity : list) {
                session.delete(indexRollbackTaskEntity);
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

    //清除建立成功索引庫
    public boolean clearBuildSuccessRecords() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        boolean result = false;
        try {
            Query query = session.createQuery("delete IndexRollbackTaskEntity where status =? ")
                    .setString(0, "Succeed");
            query.executeUpdate();
            tx.commit();
            result = true;
        } catch (Exception e) {
            tx.rollback();
            result = false;
        } finally {
            session.close();
        }
        return result;
    }

    //查詢指定排程
    public List<IndexRollbackTaskEntity> selectIndexRollbackTask(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexRollbackTaskEntity failQuery = new IndexRollbackTaskEntity();
        failQuery.setId(-1);
        List<IndexRollbackTaskEntity> result = new LinkedList<IndexRollbackTaskEntity>();
        result.add(failQuery);
        try {
            indexName = indexName.replaceAll("%", "[%]");
            result = session.createQuery("FROM IndexRollbackTaskEntity where indexName like ? order by createTime desc ")
                    .setString(0, "%" + indexName + "%")
                    .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    //查詢指定索引庫名稱是否存在
    public boolean selectIndexNameRollback(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexRollbackTaskEntity failQuery = new IndexRollbackTaskEntity();
        failQuery.setId(-1);
        List<IndexRollbackTaskEntity> result = new LinkedList<IndexRollbackTaskEntity>();
        result.add(failQuery);
        Boolean IndexNameExist = false;
        try {
            result = session.createQuery("FROM IndexRollbackTaskEntity where indexName = ? ")
                    .setString(0, indexName)
                    .list();

            for (IndexRollbackTaskEntity indexRollbackTaskEntity : result) {
                if (indexRollbackTaskEntity.getIndexName().equals(indexName)) {
                    IndexNameExist = true;
                }
            }
        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return IndexNameExist;
    }

    //查詢指定索引庫名稱的狀態
    public boolean selectIndexNameRollbackStatus(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexRollbackTaskEntity failQuery = new IndexRollbackTaskEntity();
        failQuery.setId(-1);
        List<IndexRollbackTaskEntity> result = new LinkedList<IndexRollbackTaskEntity>();
        result.add(failQuery);
        Boolean IndexNameStatus = false;
        try {
            result = session.createQuery("FROM IndexRollbackTaskEntity where indexName = ? ")
                    .setString(0, indexName)
                    .list();

            for (IndexRollbackTaskEntity indexRollbackTaskEntity : result) {
                if (indexRollbackTaskEntity.getStatus().equals("Succeed")) {
                    IndexNameStatus = true;
                }
            }
        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return IndexNameStatus;
    }

    //新增回溯任務
    public void insertIndexRollbackTask(String indexName, int weight) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        //取得現在時間
        java.util.Date utilDate = new Date();
        java.sql.Timestamp now = new java.sql.Timestamp(utilDate.getTime());
        boolean update = false;
        //如有同名任務，若此任務狀態為Succeed 則刪掉此任務，重新新增任務，若為其他狀態則不新增任務
        if (selectIndexNameRollback(indexName)) {
            if (selectIndexNameRollbackStatus(indexName)) {
                System.out.println("delete:" + indexName + ",insert new RollbackTask");
                deleteIndexRollbackTask(indexName);
                update = true;
            }
        } else {
            update = true;
        }

        IndexRollbackTaskEntity indexRollbackTask = new IndexRollbackTaskEntity();
        indexRollbackTask.setIndexName(indexName);
        indexRollbackTask.setActionFlag("");
        indexRollbackTask.setStatus("Wait");
        indexRollbackTask.setWeight(weight);
        indexRollbackTask.setCreateTime(now);
        indexRollbackTask.setUpdateTime(now);

        try {
            if (update) {
                session.saveOrUpdate(indexRollbackTask);
                tx.commit();
            }
        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }

    }

    //查詢指定id排程
    public List<IndexRollbackTaskEntity> selectIndexRollbackTaskById(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexRollbackTaskEntity failQuery = new IndexRollbackTaskEntity();
        failQuery.setId(-1);
        List<IndexRollbackTaskEntity> result = new LinkedList<IndexRollbackTaskEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM IndexRollbackTaskEntity where id = ? ")
                    .setString(0, id)
                    .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    //查詢指定indexname排程
    public List<IndexRollbackTaskEntity> selectIndexRollbackTaskByIndexName(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexRollbackTaskEntity failQuery = new IndexRollbackTaskEntity();
        failQuery.setId(-1);
        List<IndexRollbackTaskEntity> result = new LinkedList<IndexRollbackTaskEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM IndexRollbackTaskEntity where indexName = ? ")
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


    /**
     * 重啟TaskQueue
     * 若TaskQueue重啟後未將Rollback索引任務狀態改至Fail，則會執行此Sql，將未完成任務狀態改至Fail
     *
     * @param indexer
     */
    public void updateRollbackByIndexer(String indexer) {

        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        StringBuffer sqlstr = new StringBuffer();
        sqlstr.append(
                "update [opview_task].[dbo].[index_rollback_task] set [status] = 'Fail' " +
                        " where [action_flag] like '" + indexer + "%' and [status] = 'processing'");
        System.out.println("sqlstr:" + sqlstr);

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            sqlQuery.executeUpdate();
            tx.commit();
        } catch (HibernateException e) {
            tx.rollback();
        } finally {
            session.close();
        }
    }
}
