package com.eland.dao;

import com.eland.pojo.model.IndexLogEntity;
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
 * Created by kueihenglu on 2018/4/10.
 */
public class IndexLogDAO {
    public static Logger log = LoggerFactory.getLogger(IndexLogDAO.class);

    public List<IndexLogEntity> selectByUserDefined(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[index_log] WHERE 1=1 AND " + condition);
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("host", StandardBasicTypes.STRING)
                    .addScalar("indexdb", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("finish_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("indexdb_recnum", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexLogEntity indexLogEntity = new IndexLogEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexLogEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexLogEntity.setHost(String.valueOf(aResult[1]));
                indexLogEntity.setIndexdb(String.valueOf(aResult[2]));
                indexLogEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[3])));
                indexLogEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[4])));
                indexLogEntity.setStatus(String.valueOf(aResult[5]));
                indexLogEntity.setIndexdbRecnum(String.valueOf(aResult[6]));

                indexLogList.add(indexLogEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexLogDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexLogDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexLogList;

    }

    public List<IndexLogEntity> selectFailIndexLog(int num) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT top " + num + " * FROM [opview_task].[dbo].[index_log] WHERE 1=1 AND status is null or status!='Succeed' order by start_time desc" );
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("host", StandardBasicTypes.STRING)
                    .addScalar("indexdb", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("finish_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("indexdb_recnum", StandardBasicTypes.STRING)
                    .list();


            for (int i = 0; i < resultList.size(); i++) {

                IndexLogEntity indexLogEntity = new IndexLogEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexLogEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexLogEntity.setHost(String.valueOf(aResult[1]));
                indexLogEntity.setIndexdb(String.valueOf(aResult[2]));
                indexLogEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[3])));
                indexLogEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[4])));
                indexLogEntity.setStatus(String.valueOf(aResult[5]));
                indexLogEntity.setIndexdbRecnum(String.valueOf(aResult[6]));

                indexLogList.add(indexLogEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexLogDAO.selectFailIndexLog 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexLogDAO.selectFailIndexLog 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexLogList;

    }

    public List<IndexLogEntity> selectByMachineName(String machineName, String startTime, String endTime, String sortField,
                                                    String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT top 100 * FROM [opview_task].[dbo].[index_log] WHERE 1=1 " );

        if (!machineName.equals("")) {
            sqlstr.append(" AND host = ?");
        }
        if (!startTime.equals("")) {
            sqlstr.append(" AND start_time > ?" );
        }
        if (!endTime.equals("")) {
            sqlstr.append(" AND start_time < ?" );
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
            if (!machineName.equals("")) {
                sqlQuery.setString(groupParam++, machineName);
            }
            if (!startTime.equals("")) {
                sqlQuery.setString(groupParam++, startTime);
            }
            if (!endTime.equals("")) {
                sqlQuery.setString(groupParam++, endTime);
            }

            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("host", StandardBasicTypes.STRING)
                    .addScalar("indexdb", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("finish_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("indexdb_recnum", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexLogEntity indexLogEntity = new IndexLogEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                indexLogEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexLogEntity.setHost(String.valueOf(aResult[1]));
                indexLogEntity.setIndexdb(String.valueOf(aResult[2]));
                indexLogEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[3])));
                indexLogEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[4])));
                indexLogEntity.setStatus(String.valueOf(aResult[5]));
                indexLogEntity.setIndexdbRecnum(String.valueOf(aResult[6]));
                indexLogList.add(indexLogEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexLogDAO.selectByMachineName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexLogDAO.selectByMachineName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexLogList;

    }

    public List<IndexLogEntity> selectByIndexName(String indexName, String startTime, String endTime ,String sortField,
                                                  String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT top 100 * FROM [opview_task].[dbo].[index_log] WHERE 1=1 " );

        if (!indexName.equals("")) {
            indexName = indexName.replaceAll("%", "[%]");
            sqlstr.append(" AND indexdb like '%" + indexName + "%' ");
        }
        if (!startTime.equals("")) {
            sqlstr.append(" AND start_time > ?" );
        }
        if (!endTime.equals("")) {
            sqlstr.append(" AND start_time < ?" );
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
                    .addScalar("host", StandardBasicTypes.STRING)
                    .addScalar("indexdb", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("finish_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("indexdb_recnum", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                IndexLogEntity indexLogEntity = new IndexLogEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                indexLogEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                indexLogEntity.setHost(String.valueOf(aResult[1]));
                indexLogEntity.setIndexdb(String.valueOf(aResult[2]));
                indexLogEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[3])));
                indexLogEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[4])));
                indexLogEntity.setStatus(String.valueOf(aResult[5]));
                indexLogEntity.setIndexdbRecnum(String.valueOf(aResult[6]));
                indexLogList.add(indexLogEntity);
            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("IndexLogDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("IndexLogDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return indexLogList;

    }

}
