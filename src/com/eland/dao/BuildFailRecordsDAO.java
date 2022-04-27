package com.eland.dao;

import com.eland.pojo.model.BuildFailRecordsEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/4/9.
 */
public class BuildFailRecordsDAO {
    //搜尋索引建立失敗紀錄
    public List<BuildFailRecordsEntity> selectBuildFailRecords(){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        BuildFailRecordsEntity failQuery =new BuildFailRecordsEntity();
        failQuery.setId(-1);
        List<BuildFailRecordsEntity> result = new LinkedList<BuildFailRecordsEntity>();
        result.add(failQuery);
        try {
            result =  session.createQuery("FROM BuildFailRecordsEntity order by createTime desc")
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
    //清除索引建立失敗紀錄
    public boolean clearBuildFailRecords(){
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        boolean result =false;
        try {
            Query query = session.createQuery("delete BuildFailRecordsEntity ");
            query.executeUpdate();
            tx.commit();
            result=true;

        } catch (Exception e) {
            tx.rollback();
            result =false;
        } finally {
            session.close();
        }
        return result;
    }
}
