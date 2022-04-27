package com.eland.dao;

import com.eland.pojo.model.BuildFailRecordsEntity;
import com.eland.pojo.model.CustomIndexInformationEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/4/10.
 */
public class CustomIndexDAO {
    //查詢全部
    public List<CustomIndexInformationEntity> selectCustomIndexInformation(){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        CustomIndexInformationEntity failQuery =new CustomIndexInformationEntity();
        failQuery.setId(-1);
        List<CustomIndexInformationEntity> result = new LinkedList<CustomIndexInformationEntity>();
        result.add(failQuery);
        try {
            result =  session.createQuery("FROM CustomIndexInformationEntity order by indexName ")
                             .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    //新增客製索引排程
    public boolean insertCustomIndexInformation(String indexName,String min,String hour,String day,int timeoutSecond){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        CustomIndexInformationEntity insertCustomIndex =new CustomIndexInformationEntity();
        insertCustomIndex.setIndexName(indexName);
        insertCustomIndex.setMinute(min);
        insertCustomIndex.setHour(hour);
        insertCustomIndex.setDay(day);
        insertCustomIndex.setTimeoutSecond(timeoutSecond);

        Boolean update=false;
        try {
            session.saveOrUpdate(insertCustomIndex);
//            result =  session.createQuery("FROM CustomIndexInformationEntity order by indexName ")
//                             .list();
            tx.commit();
            update=true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return update;
    }
    //刪除指定客製排程
    public boolean deleteCustomIndexInformation(String id){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<CustomIndexInformationEntity> list =selectCustomIndexInformationById(id);
        Boolean delete=false;
        try {
            for(CustomIndexInformationEntity customIndexInformationEntity:list) {
                session.delete(customIndexInformationEntity);
            }
//            Query q = session.createQuery("delete CustomIndexInformationEntity where id = "+id);
//            q.executeUpdate();
//            result =  session.createQuery("FROM CustomIndexInformationEntity order by indexName ")
//                             .list();
            tx.commit();
            delete=true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return delete;
    }
    //修改指定客製索引排程
    public boolean updateCustomIndexInformation(String id,String indexName,String min,String hour,String day,int timeoutSecond){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<CustomIndexInformationEntity> list =selectCustomIndexInformationById(id);
        Boolean update=false;
        try {
            for(CustomIndexInformationEntity customIndexInformationEntity:list) {
                customIndexInformationEntity.setIndexName(indexName);
                customIndexInformationEntity.setMinute(min);
                customIndexInformationEntity.setHour(hour);
                customIndexInformationEntity.setDay(day);
                customIndexInformationEntity.setTimeoutSecond(timeoutSecond);
                session.saveOrUpdate(customIndexInformationEntity);
            }
//            Query q = session.createQuery("delete CustomIndexInformationEntity where id = "+id);
//            q.executeUpdate();
//            result =  session.createQuery("FROM CustomIndexInformationEntity order by indexName ")
//                             .list();
            tx.commit();
            update=true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return update;
    }
    //查詢指定排程
    public List<CustomIndexInformationEntity> selectCustomIndexInformation(String indexName){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        CustomIndexInformationEntity failQuery =new CustomIndexInformationEntity();
        failQuery.setId(-1);
        List<CustomIndexInformationEntity> result = new LinkedList<CustomIndexInformationEntity>();
        result.add(failQuery);
        try {
            result =  session.createQuery("FROM CustomIndexInformationEntity where indexName like ? order by indexName ")
                             .setString(0,"%"+indexName+"%")
                             .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

    //查詢指定排程
    public List<CustomIndexInformationEntity> selectCustomIndexInformationById(String id){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        CustomIndexInformationEntity failQuery =new CustomIndexInformationEntity();
        failQuery.setId(-1);
        List<CustomIndexInformationEntity> result = new LinkedList<CustomIndexInformationEntity>();
        result.add(failQuery);
        try {
            result =  session.createQuery("FROM CustomIndexInformationEntity where id = ? ")
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

    //清除索引建立失敗紀錄
//    public boolean clearBuildFailRecords(){
//        Session session = DbOpviewMaintenanceUtil.getSession();
//        Transaction tx = session.beginTransaction();
//        boolean result =false;
//        try {
//            Query query = session.createQuery("delete BuildFailRecordsEntity ");
//            query.executeUpdate();
//            tx.commit();
//            result=true;
//
//        } catch (Exception e) {
//            tx.rollback();
//            result =false;
//        } finally {
//            session.close();
//        }
//        return result;
//    }
}
