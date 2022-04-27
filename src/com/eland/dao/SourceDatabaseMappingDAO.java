package com.eland.dao;

import com.eland.pojo.model.IndexRollbackTaskEntity;
import com.eland.pojo.model.SourceDatabaseMappingEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.LinkedList;
import java.util.List;

public class SourceDatabaseMappingDAO {
    public static Logger log = LoggerFactory.getLogger(SourceDatabaseMappingDAO.class);

    //查詢資料來源
    public List<SourceDatabaseMappingEntity> selectBySource(String source) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        SourceDatabaseMappingEntity sourceDatabaseMappingEntity = new SourceDatabaseMappingEntity();
        List<SourceDatabaseMappingEntity> result = new LinkedList<SourceDatabaseMappingEntity>();
        result.add(sourceDatabaseMappingEntity);
        try {
            result = session.createQuery("FROM SourceDatabaseMappingEntity where source = ? and type =? ")
                    .setString(0, source)
                    .setString(1, "Month")
                    .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();
            log.error("selectBySource Fail!!", e);
        } finally {
            session.close();
        }
        return result;

    }

    public List<SourceDatabaseMappingEntity> selectDistinctSource() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        SourceDatabaseMappingEntity sourceDatabaseMappingEntity = new SourceDatabaseMappingEntity();
        List<SourceDatabaseMappingEntity> result = new LinkedList<SourceDatabaseMappingEntity>();
        result.add(sourceDatabaseMappingEntity);
        try {
            result = session.createQuery("Select DISTINCT source FROM SourceDatabaseMappingEntity ")
                    .list();
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            log.error("selectDistinctSource Fail!!", e);
        } finally {
            session.close();
        }
        return result;

    }


}

