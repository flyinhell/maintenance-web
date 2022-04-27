package com.eland.dao;

import com.eland.pojo.model.MachineTypeMappingEntity;
import com.eland.pojo.model.SourceDatabaseMappingEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by ccyang on 2018/8/10.
 */
public class MachineTypeMappingDAO {
    private static Logger log = Logger.getLogger("Log");
    public static Map<String, String> indexer = selectDistinctMachine("indexer");
    public static Map<String, String> standard = selectDistinctMachine("standard");
    public static Map<String, String> advanced = selectDistinctMachine("advanced");
    public static Map<String, String> staffOnly = selectDistinctMachine("staff-only");
    public static Map<String, String> instant = selectDistinctMachine("instant");
    //查詢
    public List<MachineTypeMappingEntity> selectMachineTypeMapping() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<MachineTypeMappingEntity> result = new LinkedList<MachineTypeMappingEntity>();
        try {
            result = session.createQuery("from MachineTypeMappingEntity order by machineName")
                    .list();
            tx.commit();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            tx.rollback();
        } finally {
            session.close();
        }

        return result;
    }

    //查詢(by MachineName)
    public List<MachineTypeMappingEntity> selectMachineTypeMapping(String machineName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<MachineTypeMappingEntity> result = new LinkedList<MachineTypeMappingEntity>();
        try {
            result = session.createQuery("from MachineTypeMappingEntity where machineName like ? order by machineName")
                    .setString(0, "%" + machineName + "%")
                    .list();
            tx.commit();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            tx.rollback();
        } finally {
            session.close();
        }

        return result;
    }

    //查詢(by ID)
    public List<MachineTypeMappingEntity> selectMachineTypeMappingById(String id) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List<MachineTypeMappingEntity> result = new LinkedList<MachineTypeMappingEntity>();
        try {
            result = session.createQuery("from MachineTypeMappingEntity where id = ? order by machineName")
                    .setString(0, id)
                    .list();
            tx.commit();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            tx.rollback();
        } finally {
            session.close();
        }

        return result;
    }


    //刪除指定機器設定
    public boolean deleteMachineTypeMapping(MachineTypeMappingEntity machineTypeMappingEntity) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        Boolean delete = false;
        try {
            session.delete(machineTypeMappingEntity);
            tx.commit();
            delete = true;

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return delete;
    }

    //新增
    public boolean insertIndexConfig(String machineName, String machineType, String ipAddress) {

        boolean insert = false;
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MachineTypeMappingEntity machineTypeMappingEntity = new MachineTypeMappingEntity();
        machineTypeMappingEntity.setMachineName(machineName);
        machineTypeMappingEntity.setMachineType(machineType);
        machineTypeMappingEntity.setIpAddress(ipAddress);
        try {
            session.saveOrUpdate(machineTypeMappingEntity);
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

    //取各類型的機器名稱
    public static Map<String, String> selectDistinctMachine(String machineType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MachineTypeMappingEntity machineTypeMappingEntity = new MachineTypeMappingEntity();
        List<MachineTypeMappingEntity> resultList = new LinkedList<MachineTypeMappingEntity>();
        resultList.add(machineTypeMappingEntity);
        Map<String, String> resultMap = new LinkedHashMap<>();
        try {
            if (machineType.equals("indexer")) {
                resultList = session.createQuery("from MachineTypeMappingEntity where machineType like ? order by ipAddress")
                        .setString(0, "%" + machineType + "%")
                        .list();
            } else {
                resultList = session.createQuery("from MachineTypeMappingEntity where machineType like ? order by id")
                        .setString(0, "%" + machineType + "%")
                        .list();
            }
            tx.commit();

            //將machine_name及ip_address存放在map中
            for (int i = 0; i < resultList.size(); i++) {
                resultMap.put(resultList.get(i).getMachineName(), resultList.get(i).getIpAddress());
            }
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
        return resultMap;
    }



}
