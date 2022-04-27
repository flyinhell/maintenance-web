package com.eland.dao;

import com.eland.pojo.model.IndexTaskInformationEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.type.StandardBasicTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by kueihenglu on 2018/4/12.
 */
public class IndexTaskInformationDAO {
    public static Logger log = LoggerFactory.getLogger(IndexTaskInformationDAO.class);

    public List<IndexTaskInformationEntity> insertByIndexName(String indexName, String indexType, String indexStatus) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        StringBuffer sqlInsertStr = new StringBuffer();
        StringBuffer sqlSelectStr = new StringBuffer();

        sqlInsertStr.append(
                "Insert into [opview_task].[dbo].[index_task_information] (index_name,index_type,action_flag,status," +
                        "last_build_time,build_second,size,records,update_time) values " +
                        "('" + indexName + "','" + indexType + "','','" + indexStatus + "',getdate(),0,0,0,getdate())");

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlInsertStr.toString());
            sqlQuery.executeUpdate();

            sqlSelectStr.append("SELECT * FROM [opview_task].[dbo].[index_task_information] WHERE " +
                    "index_name ='" + indexName + "' AND index_type ='" + indexType + "' AND status ='" + indexStatus + "' ");
            sqlQuery = session.createSQLQuery(sqlSelectStr.toString());

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("action_flag", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("last_build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexTaskInformationEntity indexTaskInformationEntity = new IndexTaskInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexTaskInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexTaskInformationEntity.setIndexName(String.valueOf(aResult[1]));
                indexTaskInformationEntity.setIndexType(String.valueOf(aResult[2]));
                indexTaskInformationEntity.setActionFlag(String.valueOf(aResult[3]));
                indexTaskInformationEntity.setStatus(String.valueOf(aResult[4]));
                indexTaskInformationEntity.setLastBuildTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                indexTaskInformationEntity.setRecords(Long.valueOf(String.valueOf(aResult[6])));
                indexTaskInformationEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[7])));

                indexTaskInformationList.add(indexTaskInformationEntity);

            }


            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexTaskInformationDAO.insertByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.insertByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexTaskInformationList;
    }

    public List<IndexTaskInformationEntity> deleteByIndexName(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        StringBuffer sqlDeleteStr = new StringBuffer();
        StringBuffer sqlSelectStr = new StringBuffer();

        if (!indexName.equals("")) {
            sqlSelectStr.append("SELECT * FROM [opview_task].[dbo].[index_task_information] WHERE " +
                    "index_name ='" + indexName + "' ");

            SQLQuery sqlQuery = session.createSQLQuery(sqlSelectStr.toString());

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("action_flag", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("last_build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexTaskInformationEntity indexTaskInformationEntity = new IndexTaskInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexTaskInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexTaskInformationEntity.setIndexName(String.valueOf(aResult[1]));
                indexTaskInformationEntity.setIndexType(String.valueOf(aResult[2]));
                indexTaskInformationEntity.setActionFlag(String.valueOf(aResult[3]));
                indexTaskInformationEntity.setStatus(String.valueOf(aResult[4]));
                indexTaskInformationEntity.setLastBuildTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                indexTaskInformationEntity.setRecords(Long.valueOf(String.valueOf(aResult[6])));
                indexTaskInformationEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[7])));

                indexTaskInformationList.add(indexTaskInformationEntity);

            }
        }

        sqlDeleteStr.append("Delete [opview_task].[dbo].[index_task_information] WHERE index_name ='" + indexName + "' ");

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlDeleteStr.toString());
            sqlQuery.executeUpdate();

            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexTaskInformationDAO.deleteByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.deleteByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexTaskInformationList;
    }

    public List<IndexTaskInformationEntity> updateByIndexName(String indexName, String updateIndexStatus) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        StringBuffer sqlUpdateStr = new StringBuffer();
        StringBuffer sqlSelectStr = new StringBuffer();

        if (!indexName.equals("")) {
            sqlUpdateStr.append("Update [opview_task].[dbo].[index_task_information] set status = '" + updateIndexStatus +
                    "' where index_name ='" + indexName + "' ");
        }

        try {

            SQLQuery sqlQuery = session.createSQLQuery(sqlUpdateStr.toString());
            sqlQuery.executeUpdate();

            sqlSelectStr.append("SELECT * FROM [opview_task].[dbo].[index_task_information] WHERE " +
                    "index_name ='" + indexName + "' AND status ='" + updateIndexStatus + "' ");
            sqlQuery = session.createSQLQuery(sqlSelectStr.toString());

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("action_flag", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("last_build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexTaskInformationEntity indexTaskInformationEntity = new IndexTaskInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexTaskInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexTaskInformationEntity.setIndexName(String.valueOf(aResult[1]));
                indexTaskInformationEntity.setIndexType(String.valueOf(aResult[2]));
                indexTaskInformationEntity.setActionFlag(String.valueOf(aResult[3]));
                indexTaskInformationEntity.setStatus(String.valueOf(aResult[4]));
                indexTaskInformationEntity.setLastBuildTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                indexTaskInformationEntity.setRecords(Long.valueOf(String.valueOf(aResult[6])));
                indexTaskInformationEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[7])));

                indexTaskInformationList.add(indexTaskInformationEntity);

            }


            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexTaskInformationDAO.updateByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.updateByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexTaskInformationList;
    }

    public List<IndexTaskInformationEntity> selectByUserDefined(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[index_task_information] WHERE 1=1 AND " + condition);
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("action_flag", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("last_build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexTaskInformationEntity indexTaskInformationEntity = new IndexTaskInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexTaskInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexTaskInformationEntity.setIndexName(String.valueOf(aResult[1]));
                indexTaskInformationEntity.setIndexType(String.valueOf(aResult[2]));
                indexTaskInformationEntity.setActionFlag(String.valueOf(aResult[3]));
                indexTaskInformationEntity.setStatus(String.valueOf(aResult[4]));
                indexTaskInformationEntity.setLastBuildTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                indexTaskInformationEntity.setRecords(Long.valueOf(String.valueOf(aResult[6])));
                indexTaskInformationEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[7])));

                indexTaskInformationList.add(indexTaskInformationEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexTaskInformationDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexTaskInformationList;
    }

    public List<IndexTaskInformationEntity> selectByIndexName(String indexName, String sortField,
                                                              String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[index_task_information] WHERE 1=1 ");

        if (!indexName.equals("")) {
            indexName = indexName.replaceAll("%", "[%]");
            sqlstr.append(" AND index_name like '%" + indexName + "%' ");
        }
        if (!sortField.equals("")) {
            sqlstr.append(" ORDER BY " + sortField);
        }
        if (!sortType.equals("")) {
            sqlstr.append(" " + sortType);
        }

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("action_flag", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("last_build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexTaskInformationEntity indexTaskInformationEntity = new IndexTaskInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexTaskInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexTaskInformationEntity.setIndexName(String.valueOf(aResult[1]));
                indexTaskInformationEntity.setIndexType(String.valueOf(aResult[2]));
                indexTaskInformationEntity.setActionFlag(String.valueOf(aResult[3]));
                indexTaskInformationEntity.setStatus(String.valueOf(aResult[4]));
                indexTaskInformationEntity.setLastBuildTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                indexTaskInformationEntity.setRecords(Long.valueOf(String.valueOf(aResult[6])));
                indexTaskInformationEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[7])));

                indexTaskInformationList.add(indexTaskInformationEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexTaskInformationDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexTaskInformationList;
    }

    public List<IndexTaskInformationEntity> selectByIndexStatus(String indexStatus, String sortField, String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[index_task_information] WHERE 1=1 ");

        if (!indexStatus.equals("")) {
            sqlstr.append(" AND status = ?");
        }
        if (indexStatus.equals("Non-Succeed")) {
            sqlstr.append(" or status = 'Processing' or status = 'Fail'or status ='Rebuild'");
        }
        if (!sortField.equals("")) {
            sqlstr.append(" ORDER BY " + sortField);
        }
        if (!sortType.equals("")) {
            sqlstr.append(" " + sortType);
        }
        System.out.println("sqlstr:" + sqlstr);
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            int groupParam = 0;
            if (!indexStatus.equals("")) {
                sqlQuery.setString(groupParam++, indexStatus);
            }

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("action_flag", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("last_build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexTaskInformationEntity indexTaskInformationEntity = new IndexTaskInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexTaskInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexTaskInformationEntity.setIndexName(String.valueOf(aResult[1]));
                indexTaskInformationEntity.setIndexType(String.valueOf(aResult[2]));
                indexTaskInformationEntity.setActionFlag(String.valueOf(aResult[3]));
                indexTaskInformationEntity.setStatus(String.valueOf(aResult[4]));
                indexTaskInformationEntity.setLastBuildTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                indexTaskInformationEntity.setRecords(Long.valueOf(String.valueOf(aResult[6])));
                indexTaskInformationEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[7])));

                indexTaskInformationList.add(indexTaskInformationEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexTaskInformationDAO.selectByIndexStatus 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.selectByIndexStatus 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexTaskInformationList;

    }

    /**
     * 重啟TaskQueue
     * 若TaskQueue重啟後未將索引任務狀態改至Fail，則會執行此Sql，將未完成任務狀態改至Fail
     *
     * @param indexer
     */
    public void updateByIndexer(String indexer) {

        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        StringBuffer sqlstr = new StringBuffer();
        sqlstr.append(
                "update [opview_task].[dbo].[index_task_information] set [status] = 'Fail' " +
                        " where [action_flag] like '" + indexer + "%' and [status] = 'processing'");
        System.out.println("sqlstr:" + sqlstr);

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            sqlQuery.executeUpdate();
            tx.commit();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.updateByIndexer 發生錯誤：", e);
            tx.rollback();
        } finally {
            session.close();
        }
    }

    public List<IndexTaskInformationEntity> selectByIndexTimeRange(String startTime, String endTime, String sortField,
                                                                   String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[index_task_information] WHERE 1=1 ");

        if (!startTime.equals("")) {
            sqlstr.append(" AND last_build_time > ?");
        }
        if (!endTime.equals("")) {
            sqlstr.append(" AND last_build_time < ?");
        }
        if (!sortField.equals("")) {
            sqlstr.append(" ORDER BY " + sortField);
        }
        if (!sortType.equals("")) {
            sqlstr.append(" " + sortType);
        }

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());

            int groupParam = 0;
            if (!startTime.equals("")) {
                sqlQuery.setString(groupParam++, startTime);
            }
            if (!endTime.equals("")) {
                sqlQuery.setString(groupParam++, endTime);
            }

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("action_flag", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("last_build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexTaskInformationEntity indexTaskInformationEntity = new IndexTaskInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexTaskInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexTaskInformationEntity.setIndexName(String.valueOf(aResult[1]));
                indexTaskInformationEntity.setIndexType(String.valueOf(aResult[2]));
                indexTaskInformationEntity.setActionFlag(String.valueOf(aResult[3]));
                indexTaskInformationEntity.setStatus(String.valueOf(aResult[4]));
                indexTaskInformationEntity.setLastBuildTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                indexTaskInformationEntity.setRecords(Long.valueOf(String.valueOf(aResult[6])));
                indexTaskInformationEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[7])));

                indexTaskInformationList.add(indexTaskInformationEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexTaskInformationDAO.selectByIndexTimeRange 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexTaskInformationDAO.selectByIndexTimeRange 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexTaskInformationList;

    }
}
