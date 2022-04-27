package com.eland.dao;

import com.eland.pojo.model.IndexInformationEntity;
import com.eland.pojo.model.MonthyTaskConfigEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/11/28.
 */
public class IndexInformationDAO {
    private static Logger log = Logger.getLogger("Log");

    public List<IndexInformationEntity> list() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        List<IndexInformationEntity> resultList = null;
        try {
            log.info("Select * From index_information");

            resultList = session.createQuery("FROM  IndexInformationEntity ")
                                .list();
        } catch (Exception e) {
            log.error("AccountDAO.list 發生錯誤： ", e);
        } finally {
            session.close();
        }
        return resultList;
    }


    public boolean insertIndexInformation(String indexName, String indexType,
                                          String dateRange, String databaseType,
                                          String databaseAddress, String viewName,
                                          String pType2) {

        boolean insert = false;
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexInformationEntity indexInformationEntity = new IndexInformationEntity();
        indexInformationEntity.setIndexName(indexName);
        indexInformationEntity.setIndexType(indexType);
        indexInformationEntity.setDateRange(dateRange);
        indexInformationEntity.setDatabaseAddress(databaseAddress);
        indexInformationEntity.setDatabaseType(databaseType);
        indexInformationEntity.setViewName(viewName);
        indexInformationEntity.setpType2(pType2);

        try {
            session.saveOrUpdate(indexInformationEntity);
            tx.commit();
            insert = true;
        } catch (Exception e) {
            tx.rollback();
            insert = false;

        } finally {
            session.close();
        }
        return insert;
    }

    public List<IndexInformationEntity> selectIndexInformation(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexInformationEntity failQuery = new IndexInformationEntity();
        List<IndexInformationEntity> result = new LinkedList<IndexInformationEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM IndexInformationEntity WHERE indexName like ? order by indexName asc")
                            .setString(0, "%" + indexName + "%")
                            .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }


    public List<IndexInformationEntity> selectIndexInformationById(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexInformationEntity failQuery = new IndexInformationEntity();
        List<IndexInformationEntity> result = new LinkedList<IndexInformationEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM IndexInformationEntity WHERE id = ? ")
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


    //修改指定索引設定
    public boolean updateIndexInformationDatabase(String id, String viewName, String databaseType,
                                                  String databaseAddress) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<IndexInformationEntity> list = selectIndexInformationById(id);
        Boolean update = false;
        try {
            for (IndexInformationEntity indexInformationEntity : list) {
                indexInformationEntity.setViewName(viewName);
                indexInformationEntity.setDatabaseType(databaseType);
                indexInformationEntity.setDatabaseAddress(databaseAddress);
                session.saveOrUpdate(indexInformationEntity);
            }
            tx.commit();
            update = true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return update;
    }

    //修改指定索引設定
    public boolean updateIndexInformation(String id, String indexType, String dateRange, String pType2) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<IndexInformationEntity> list = selectIndexInformationById(id);
        Boolean update = false;
        try {
            for (IndexInformationEntity indexInformationEntity : list) {
                indexInformationEntity.setIndexType(indexType);
                indexInformationEntity.setDateRange(dateRange);
                indexInformationEntity.setpType2(pType2);
                session.saveOrUpdate(indexInformationEntity);
            }
            tx.commit();
            update = true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return update;
    }

    //刪除指定索引設定
    public boolean deleteIndexInformation(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        Boolean delete = false;
        List<IndexInformationEntity> list = selectIndexInformation(indexName);
        try {
            for (IndexInformationEntity indexInformationEntity : list) {
                session.delete(indexInformationEntity);
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

}
