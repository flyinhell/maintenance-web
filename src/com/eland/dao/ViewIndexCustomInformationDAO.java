package com.eland.dao;

import com.eland.pojo.model.VwIndexCustomInformationEntity;
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
 * Created by zhenfu on 2020/5/11.
 */

public class ViewIndexCustomInformationDAO {

    public static Logger log = LoggerFactory.getLogger(ViewIndexCustomInformationDAO.class);

    //搜尋未完成或失敗的複製任務清單
    public List<VwIndexCustomInformationEntity> selectUnfinishedTask() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<VwIndexCustomInformationEntity> VwIndexCustomInformationList = new LinkedList<VwIndexCustomInformationEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[vw_index_custom_information] WHERE 1=1 AND status is null or status!='Succeed' or copy_status!='DONE' order by start_time desc ");
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("copy_machine_name", StandardBasicTypes.STRING)
                    .addScalar("copy_status", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                VwIndexCustomInformationEntity VwIndexCustomInformationEntity = new VwIndexCustomInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                VwIndexCustomInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                VwIndexCustomInformationEntity.setIndexName(String.valueOf(aResult[1]));
                VwIndexCustomInformationEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                VwIndexCustomInformationEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                VwIndexCustomInformationEntity.setStatus(String.valueOf(aResult[4]));
                VwIndexCustomInformationEntity.setSize(String.valueOf(aResult[5]));
                VwIndexCustomInformationEntity.setRecords(String.valueOf(aResult[6]));
                VwIndexCustomInformationEntity.setCopyMachineName(String.valueOf(aResult[7]));
                VwIndexCustomInformationEntity.setCopyStatus(String.valueOf(aResult[8]));


                VwIndexCustomInformationList.add(VwIndexCustomInformationEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("ViewIndexCustomInformationDAO.selectUnfinishedTask 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("ViewIndexCustomInformationDAO.selectUnfinishedTask 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return VwIndexCustomInformationList;


    }

    //自訂搜尋條件
    public List<VwIndexCustomInformationEntity> selectByUserDefined(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<VwIndexCustomInformationEntity> CustomIndexStatusList = new LinkedList<VwIndexCustomInformationEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[vw_index_custom_information] WHERE 1=1 AND " + condition);

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("copy_machine_name", StandardBasicTypes.STRING)
                    .addScalar("copy_status", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                VwIndexCustomInformationEntity VwIndexCustomInformationEntity = new VwIndexCustomInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                VwIndexCustomInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                VwIndexCustomInformationEntity.setIndexName(String.valueOf(aResult[1]));
                VwIndexCustomInformationEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                VwIndexCustomInformationEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                VwIndexCustomInformationEntity.setStatus(String.valueOf(aResult[4]));
                VwIndexCustomInformationEntity.setSize(String.valueOf(aResult[5]));
                VwIndexCustomInformationEntity.setRecords(String.valueOf(aResult[6]));
                VwIndexCustomInformationEntity.setCopyMachineName(String.valueOf(aResult[7]));
                VwIndexCustomInformationEntity.setCopyStatus(String.valueOf(aResult[8]));

                CustomIndexStatusList.add(VwIndexCustomInformationEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("ViewIndexCustomInformationDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("ViewIndexCustomInformationDAO.selectByUserDefined 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return CustomIndexStatusList;
    }

    //以index_name為搜尋條件
    public List<VwIndexCustomInformationEntity> selectByIndexName(String indexName, String startTime, String endTime, String sortField, String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<VwIndexCustomInformationEntity> CustomIndexStatusList = new LinkedList<VwIndexCustomInformationEntity>();
        StringBuffer sqlstr = new StringBuffer();
        indexName = indexName.replaceAll("%", "[%]");
        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[vw_index_custom_information] WHERE 1=1 AND index_name like '%" + indexName + "%' ");

        if (!startTime.equals("")) {
            sqlstr.append(" AND start_time > '" + startTime + "' ");
        }
        if (!endTime.equals("")) {
            sqlstr.append(" AND start_time < '" + endTime + "' ");
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
                    .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("build_millisecond", StandardBasicTypes.STRING)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("size", StandardBasicTypes.STRING)
                    .addScalar("records", StandardBasicTypes.STRING)
                    .addScalar("copy_machine_name", StandardBasicTypes.STRING)
                    .addScalar("copy_status", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                VwIndexCustomInformationEntity VwIndexCustomInformationEntity = new VwIndexCustomInformationEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                VwIndexCustomInformationEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                VwIndexCustomInformationEntity.setIndexName(String.valueOf(aResult[1]));
                VwIndexCustomInformationEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[2])));
                VwIndexCustomInformationEntity.setBuildMillisecond(String.valueOf(aResult[3]));
                VwIndexCustomInformationEntity.setStatus(String.valueOf(aResult[4]));
                VwIndexCustomInformationEntity.setSize(String.valueOf(aResult[5]));
                VwIndexCustomInformationEntity.setRecords(String.valueOf(aResult[6]));
                VwIndexCustomInformationEntity.setCopyMachineName(String.valueOf(aResult[7]));
                VwIndexCustomInformationEntity.setCopyStatus(String.valueOf(aResult[8]));

                CustomIndexStatusList.add(VwIndexCustomInformationEntity);

            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("ViewIndexCustomInformationDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("ViewIndexCustomInformationDAO.selectByIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return CustomIndexStatusList;
    }


}
