package com.eland.dao;

import com.eland.pojo.model.CustomIndexStatusEntity;
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
 * Created by zhenfu on 2020/5/07.
 */

public class CustomIndexStatusDAO {

    public static Logger log = LoggerFactory.getLogger(CustomIndexStatusDAO.class);

    //搜尋未完成或失敗的複製任務清單
    public List<CustomIndexStatusEntity> selectUnfinishedTask() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<CustomIndexStatusEntity> CustomIndexStatusList = new LinkedList<CustomIndexStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[custom_index_status] WHERE 1=1 AND status is null or status!='Succeed' order by start_time desc ");
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                CustomIndexStatusEntity customIndexStatusEntity = new CustomIndexStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                customIndexStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                customIndexStatusEntity.setIndexName(String.valueOf(aResult[1]));
                customIndexStatusEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                customIndexStatusEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                customIndexStatusEntity.setStatus(String.valueOf(aResult[4]));
                customIndexStatusEntity.setSize(String.valueOf(aResult[5]));
                customIndexStatusEntity.setRecords(String.valueOf(aResult[6]));

                CustomIndexStatusList.add(customIndexStatusEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("CustomIndexStatusDAO.selectUnfinishedTask 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("CustomIndexStatusDAO.selectUnfinishedTask 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return CustomIndexStatusList;


    }

    //自訂搜尋條件
    public List<CustomIndexStatusEntity> selectByUserDefined(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<CustomIndexStatusEntity> CustomIndexStatusList = new LinkedList<CustomIndexStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[custom_index_status] WHERE 1=1 AND " + condition);

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                CustomIndexStatusEntity customIndexStatusEntity = new CustomIndexStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                customIndexStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                customIndexStatusEntity.setIndexName(String.valueOf(aResult[1]));
                customIndexStatusEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                customIndexStatusEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                customIndexStatusEntity.setStatus(String.valueOf(aResult[4]));
                customIndexStatusEntity.setSize(String.valueOf(aResult[5]));
                customIndexStatusEntity.setRecords(String.valueOf(aResult[6]));

                CustomIndexStatusList.add(customIndexStatusEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("CustomIndexStatusDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("CustomIndexStatusDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return CustomIndexStatusList;
    }

    //以index_name為搜尋條件
    public List<CustomIndexStatusEntity> selectByIndexName(String indexName, String sortField, String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<CustomIndexStatusEntity> CustomIndexStatusList = new LinkedList<CustomIndexStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[custom_index_status] WHERE 1=1 AND index_name like '%" + indexName + "%' ");

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
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                CustomIndexStatusEntity customIndexStatusEntity = new CustomIndexStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                customIndexStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                customIndexStatusEntity.setIndexName(String.valueOf(aResult[1]));
                customIndexStatusEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                customIndexStatusEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                customIndexStatusEntity.setStatus(String.valueOf(aResult[4]));
                customIndexStatusEntity.setSize(String.valueOf(aResult[5]));
                customIndexStatusEntity.setRecords(String.valueOf(aResult[6]));

                CustomIndexStatusList.add(customIndexStatusEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("CustomIndexStatusDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("CustomIndexStatusDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return CustomIndexStatusList;
    }


}
