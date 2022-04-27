package com.eland.dao;

import com.eland.pojo.model.ApiIndexStatusEntity;
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
public class ApiIndexStatusDAO {

    public static Logger log = LoggerFactory.getLogger(ApiIndexStatusDAO.class);

    //搜尋未完成或失敗的複製任務清單
    public List<ApiIndexStatusEntity> selectUnfinishedTask() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<ApiIndexStatusEntity> apiIndexStatusList = new LinkedList<ApiIndexStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[api_index_status] WHERE 1=1 AND status is null or status!='Succeed' order by build_time desc ");
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                ApiIndexStatusEntity apiIndexStatusEntity = new ApiIndexStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                apiIndexStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                apiIndexStatusEntity.setIndexName(String.valueOf(aResult[1]));
                apiIndexStatusEntity.setBuildTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                apiIndexStatusEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                apiIndexStatusEntity.setStatus(String.valueOf(aResult[4]));
                apiIndexStatusEntity.setSize(String.valueOf(aResult[5]));
                apiIndexStatusEntity.setRecords(String.valueOf(aResult[6]));

                apiIndexStatusList.add(apiIndexStatusEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("ApiIndexStatusDAO.selectUnfinishedTask 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("ApiIndexStatusDAO.selectUnfinishedTask 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return apiIndexStatusList;


    }

    //自訂搜尋條件
    public List<ApiIndexStatusEntity> selectByUserDefined(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<ApiIndexStatusEntity> apiIndexStatusList = new LinkedList<ApiIndexStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[api_index_status] WHERE 1=1 AND " + condition);

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                ApiIndexStatusEntity apiIndexStatusEntity = new ApiIndexStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                apiIndexStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                apiIndexStatusEntity.setIndexName(String.valueOf(aResult[1]));
                apiIndexStatusEntity.setBuildTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                apiIndexStatusEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                apiIndexStatusEntity.setStatus(String.valueOf(aResult[4]));
                apiIndexStatusEntity.setSize(String.valueOf(aResult[5]));
                apiIndexStatusEntity.setRecords(String.valueOf(aResult[6]));

                apiIndexStatusList.add(apiIndexStatusEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("ApiIndexStatusDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("ApiIndexStatusDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return apiIndexStatusList;
    }

    //以index_name為搜尋條件
    public List<ApiIndexStatusEntity> selectByIndexName(String indexName, String sortField, String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<ApiIndexStatusEntity> apiIndexStatusList = new LinkedList<ApiIndexStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();
        indexName = indexName.replaceAll("%", "[%]");
        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[api_index_status] WHERE 1=1 AND index_name like '%" + indexName + "%' ");

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
                    .addScalar("build_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                ApiIndexStatusEntity apiIndexStatusEntity = new ApiIndexStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                apiIndexStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                apiIndexStatusEntity.setIndexName(String.valueOf(aResult[1]));
                apiIndexStatusEntity.setBuildTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                apiIndexStatusEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                apiIndexStatusEntity.setStatus(String.valueOf(aResult[4]));
                apiIndexStatusEntity.setSize(String.valueOf(aResult[5]));
                apiIndexStatusEntity.setRecords(String.valueOf(aResult[6]));

                apiIndexStatusList.add(apiIndexStatusEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("ApiIndexStatusDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("ApiIndexStatusDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return apiIndexStatusList;
    }

}
