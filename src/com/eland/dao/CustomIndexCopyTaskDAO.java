package com.eland.dao;

import com.eland.pojo.model.CustomIndexCopyTaskEntity;
import com.eland.pojo.model.IncrementalIndexStatusEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.LinkedList;
import java.util.List;

public class CustomIndexCopyTaskDAO {

    public static Logger log = LoggerFactory.getLogger(CustomIndexCopyTaskDAO.class);

    public void updateStatus(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        CustomIndexCopyTaskEntity customIndexCopyTaskEntity = new CustomIndexCopyTaskEntity();
        try {
            session.createQuery("update CustomIndexCopyTaskEntity set status = 'Fail' where indexName = ? and status is null")
                    .setString(0, indexName)
                    .executeUpdate();
            tx.commit();
        } catch (Exception e) {
            log.error("CustomIndexCopyTaskDAO.updateStatus 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }
    }
}
