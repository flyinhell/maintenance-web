package com.eland.dao;

import com.eland.pojo.model.CustomIndexInformationEntity;
import com.eland.pojo.model.MonthyTaskCheckEntity;
import com.eland.pojo.model.MonthyTaskConfigEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/8/28.
 */
public class MonthyIndexConfigDAO {
    public boolean insertIndexConfig(String indexName, String indexType, String machineNameList,
                                     String priority, String module, String customer,
                                     String sourceType, String contentType,
                                     String viewName, String databaseType,
                                     String databaseAddress, String viewSchema) {

        boolean insert = false;
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();

        MonthyTaskConfigEntity monthyTaskConfigEntity = new MonthyTaskConfigEntity();
        monthyTaskConfigEntity.setIndexName(indexName);
        monthyTaskConfigEntity.setIndexType(indexType);
        monthyTaskConfigEntity.setMachineNameList(machineNameList);
        monthyTaskConfigEntity.setPriority(priority);
        monthyTaskConfigEntity.setModule(module);
        monthyTaskConfigEntity.setCustomer(customer);
        monthyTaskConfigEntity.setSourceType(sourceType);
        monthyTaskConfigEntity.setContentType(contentType);
        monthyTaskConfigEntity.setViewName(viewName);
        monthyTaskConfigEntity.setDatabaseType(databaseType);
        monthyTaskConfigEntity.setDatabaseAddress(databaseAddress);
        monthyTaskConfigEntity.setViewSchema(viewSchema);
        try {
            session.saveOrUpdate(monthyTaskConfigEntity);
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


    public List<MonthyTaskConfigEntity> selectMonthyTaskConfig() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyTaskConfigEntity failQuery = new MonthyTaskConfigEntity();
        List<MonthyTaskConfigEntity> result = new LinkedList<MonthyTaskConfigEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM MonthyTaskConfigEntity order by indexName asc").list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }


    public List<MonthyTaskConfigEntity> selectMonthyTaskConfig(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyTaskConfigEntity failQuery = new MonthyTaskConfigEntity();
        List<MonthyTaskConfigEntity> result = new LinkedList<MonthyTaskConfigEntity>();
        result.add(failQuery);
        try {
            indexName = indexName.replaceAll("%", "[%]");
            result = session.createQuery("FROM MonthyTaskConfigEntity WHERE indexName like ? order by indexName asc")
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

    public List<MonthyTaskConfigEntity> selectMonthyTaskConfigById(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyTaskConfigEntity failQuery = new MonthyTaskConfigEntity();
        List<MonthyTaskConfigEntity> result = new LinkedList<MonthyTaskConfigEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM MonthyTaskConfigEntity WHERE id = ? ")
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


    //刪除指定索引設定
    public boolean deleteMonthyTaskConfig(MonthyTaskConfigEntity monthyTaskConfigEntity) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        Boolean delete = false;
        try {
            session.delete(monthyTaskConfigEntity);
            tx.commit();
            delete = true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return delete;
    }

    //修改指定索引設定
    public boolean updateIndexConfigMachine(String id, String indexType, String machineNameList, String priority) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<MonthyTaskConfigEntity> list = selectMonthyTaskConfigById(id);
        Boolean update = false;
        try {
            for (MonthyTaskConfigEntity monthyTaskConfigEntity : list) {
                monthyTaskConfigEntity.setIndexType(indexType);
                monthyTaskConfigEntity.setMachineNameList(machineNameList);
                monthyTaskConfigEntity.setPriority(priority);
                session.saveOrUpdate(monthyTaskConfigEntity);
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
    public boolean updateIndexConfigMapping(String id, String module, String customer, String sourceType,
                                            String contentType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<MonthyTaskConfigEntity> list = selectMonthyTaskConfigById(id);
        Boolean update = false;
        try {
            for (MonthyTaskConfigEntity monthyTaskConfigEntity : list) {
                monthyTaskConfigEntity.setModule(module);
                monthyTaskConfigEntity.setCustomer(customer);
                monthyTaskConfigEntity.setSourceType(sourceType);
                monthyTaskConfigEntity.setContentType(contentType);
                session.saveOrUpdate(monthyTaskConfigEntity);
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
    public boolean updateIndexConfigDatabase(String id, String viewName, String databaseType, String databaseAddress) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<MonthyTaskConfigEntity> list = selectMonthyTaskConfigById(id);
        Boolean update = false;
        try {

            for (MonthyTaskConfigEntity monthyTaskConfigEntity : list) {
                monthyTaskConfigEntity.setViewName(viewName);
                monthyTaskConfigEntity.setDatabaseType(databaseType);
                monthyTaskConfigEntity.setDatabaseAddress(databaseAddress);
                session.saveOrUpdate(monthyTaskConfigEntity);
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
    public boolean updateIndexConfigSchema(String id, String viewSchema) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<MonthyTaskConfigEntity> list = selectMonthyTaskConfigById(id);
        Boolean update = false;
        try {

            for (MonthyTaskConfigEntity monthyTaskConfigEntity : list) {
                monthyTaskConfigEntity.setViewSchema(viewSchema);
                session.saveOrUpdate(monthyTaskConfigEntity);
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
}
