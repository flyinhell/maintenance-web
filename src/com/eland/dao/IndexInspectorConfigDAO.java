package com.eland.dao;

import com.eland.pojo.model.IndexInspectorConfigEntity;
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
public class IndexInspectorConfigDAO {
    private static Logger log = Logger.getLogger("Log");

    public List<IndexInspectorConfigEntity> list() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        List<IndexInspectorConfigEntity> resultList = null;
        try {
            log.info("Select * From index_inspector_config");
            resultList = session.createQuery("FROM  IndexInspectorConfigEntity ")
                    .list();
        } catch (Exception e) {
            log.error("IndexInspectorConfigDAO.list 發生錯誤： ", e);
        } finally {
            session.close();
        }
        return resultList;
    }

    public List<IndexInspectorConfigEntity> selectIndexInspectorConfig(String indexName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexInspectorConfigEntity failQuery = new IndexInspectorConfigEntity();
        List<IndexInspectorConfigEntity> result = new LinkedList<IndexInspectorConfigEntity>();
        result.add(failQuery);
        try {
            indexName = indexName.replaceAll("%", "[%]");
            result = session.createQuery("FROM IndexInspectorConfigEntity WHERE indexName like ? order by indexName asc")
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

    public List<IndexInspectorConfigEntity> selectIndexInspectorConfigById(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexInspectorConfigEntity failQuery = new IndexInspectorConfigEntity();
        List<IndexInspectorConfigEntity> result = new LinkedList<IndexInspectorConfigEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM IndexInspectorConfigEntity WHERE id = ? ")
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


    public boolean insertIndexInspectorConfig(String indexName, String indexType,
                                              String immediate, String standardSwitch,
                                              String staffSwitch, String advancedSwitch, String instantSwitch,
                                              String checkImmediateSql) {


        boolean insert = false;
        String configInspectSwitch = "None";
        try {
            LinkedHashSet<String> inspectSwitch = new LinkedHashSet<String>();
            // String[] inspectSwitch = new String[3];
            if (standardSwitch.equals("true")) {
                inspectSwitch.add("standard");
            }
            if (staffSwitch.equals("true")) {
                inspectSwitch.add("staff-only");
            }
            if (advancedSwitch.equals("true")) {
                inspectSwitch.add("advanced");
            }
            if (instantSwitch.equals("true")) {
                inspectSwitch.add("instant");
            }

            if (inspectSwitch.size() > 0) {
                configInspectSwitch = "";
                for (String Switch : inspectSwitch) {
                    configInspectSwitch = configInspectSwitch + Switch + ";";
                }
                configInspectSwitch.substring(0, configInspectSwitch.length() - 1);
            }
        } catch (Exception e) {
            configInspectSwitch = "None";
        }

        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IndexInspectorConfigEntity indexInspectorConfigEntity = new IndexInspectorConfigEntity();
        indexInspectorConfigEntity.setIndexName(indexName);
        indexInspectorConfigEntity.setIndexType(indexType);
        indexInspectorConfigEntity.setImmediate(immediate);
        indexInspectorConfigEntity.setInspectSwitch(configInspectSwitch);
        indexInspectorConfigEntity.setCheckImmediateSql(checkImmediateSql);

        try {
            session.saveOrUpdate(indexInspectorConfigEntity);
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


    //修改指定索引設定
    public boolean updateIndexInspectorConfig(String id, String checkImmediateSql) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<IndexInspectorConfigEntity> list = selectIndexInspectorConfigById(id);
        Boolean update = false;
        try {

            for (IndexInspectorConfigEntity indexInspectorConfigEntity : list) {
                indexInspectorConfigEntity.setCheckImmediateSql(checkImmediateSql);
                session.saveOrUpdate(indexInspectorConfigEntity);
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
    public boolean updateIndexInspectorConfig(String id, String indexType, String immediate, String inspectSwitch) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<IndexInspectorConfigEntity> list = selectIndexInspectorConfigById(id);
        Boolean update = false;
        try {
            for (IndexInspectorConfigEntity indexInspectorConfigEntity : list) {
                indexInspectorConfigEntity.setIndexType(indexType);
                indexInspectorConfigEntity.setImmediate(immediate);
                indexInspectorConfigEntity.setInspectSwitch(inspectSwitch);
                session.saveOrUpdate(indexInspectorConfigEntity);
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
    public boolean deleteIndexInspectorConfig(IndexInspectorConfigEntity indexInspectorConfigEntity) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        Boolean delete = false;
        try {
            session.delete(indexInspectorConfigEntity);
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
