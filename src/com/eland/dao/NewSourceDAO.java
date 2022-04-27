package com.eland.dao;

import com.eland.pojo.model.IndexRollbackTaskEntity;
import com.eland.pojo.model.WhSourceTypeDevEntity;
import com.eland.pojo.model.WhSourceTypeEntity;
import com.eland.util.ConnectDB;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.type.StandardBasicTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.xml.bind.SchemaOutputResolver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class NewSourceDAO {
    public static Logger log = LoggerFactory.getLogger(NewSourceDAO.class);


    public List<WhSourceTypeEntity> selectNewSource(String condition) {
        Session session = DbOpviewMaintenanceUtil.getSession127();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<WhSourceTypeEntity> newSourceList = new LinkedList<WhSourceTypeEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM wh_query.wh_source_type WHERE 1=1 AND " + condition);
        try {
            //System.out.println("sqlstr:"+sqlstr.toString());
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            resultList = sqlQuery.addScalar("source_id", StandardBasicTypes.STRING)
                    .addScalar("source_name", StandardBasicTypes.STRING)
                    .addScalar("p_type", StandardBasicTypes.STRING)
                    .addScalar("p_type_2", StandardBasicTypes.STRING)
                    .list();

            for (int i = 0; i < resultList.size(); i++) {

                WhSourceTypeEntity newSourceEntity = new WhSourceTypeEntity();
                Object[] aResult = (Object[]) resultList.get(i);
                newSourceEntity.setSourceId(String.valueOf(aResult[0]));
                newSourceEntity.setSourceName(String.valueOf(aResult[1]));
                newSourceEntity.setpType(String.valueOf(aResult[2]));
                newSourceEntity.setpType2(String.valueOf(aResult[3]));
                newSourceList.add(newSourceEntity);
            }
            tx.commit();
        } catch (NumberFormatException e) {
            log.error("newSourceDAO.selectNewSource 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (HibernateException e) {
            log.error("newSourceDAO.selectNewSource 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }
        return newSourceList;
    }

    //刪除指定新來源
    public boolean deleteNewSource(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<WhSourceTypeEntity> list = selectNewSourceById(id);
        Boolean delete = false;
        try {
            for (WhSourceTypeEntity whSourceTypeEntity : list) {
                session.delete(whSourceTypeEntity);
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


    //查詢指定排程
    public List<WhSourceTypeEntity> selectNewSourceById(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession127();
        Transaction tx = session.beginTransaction();
        WhSourceTypeEntity failQuery = new WhSourceTypeEntity();
        // failQuery.setId(-1);
        List<WhSourceTypeEntity> result = new LinkedList<WhSourceTypeEntity>();
        //  result.add(failQuery);
        try {
            result = session.createQuery("FROM WhSourceTypeEntity where sourceId = ? ")
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

    //新增新來源
    public boolean insertNewSource(String sourceId, String sourceName, String ptype, String ptype2) {
        Session session = DbOpviewMaintenanceUtil.getSession127();
        Transaction tx = session.beginTransaction();

        //System.out.println("sourceName:"+sourceName);
        WhSourceTypeEntity newSource = new WhSourceTypeEntity();
        newSource.setSourceId(sourceId);
        newSource.setSourceName(sourceName);
        newSource.setpType(ptype);
        newSource.setpType2(ptype2);

        Boolean update = false;
        try {
            session.saveOrUpdate(newSource);
            tx.commit();
            update=true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }
        return update;
    }

    //顯示新增sql語法
    public String getInsertSQL(String[] sourceId, String[] sourceName, String[] ptype, String[] ptype2) {
        String sql = "INSERT INTO wh_query.wh_source_type (source_id, source_name, p_type, p_type_2) VALUES ";

        for(int i = 0 ; i < sourceId.length; i ++){
            if(i != 0){
                sql += ",";
            }
            sql += "('" + sourceId[i] + "', '" + sourceName[i] + "', '" + ptype[i] + "', '" + ptype2[i] + "')";
        }

        return sql + ";";
    }

    //新增新來源DEV
    public boolean insertNewSourceDev(String sourceId, String sourceName, String ptype, String ptype2) {
        Session session = DbOpviewMaintenanceUtil.getSession127();
        Transaction tx = session.beginTransaction();

        WhSourceTypeDevEntity newSource = new WhSourceTypeDevEntity();
        newSource.setSourceId(sourceId);
        newSource.setSourceName(sourceName);
        newSource.setpType(ptype);
        newSource.setpType2(ptype2);

        Boolean update = false;
        try {
            session.saveOrUpdate(newSource);
            tx.commit();
            update = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }
        return update;
    }


}
