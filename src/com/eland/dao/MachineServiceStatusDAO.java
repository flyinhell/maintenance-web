package com.eland.dao;

import com.eland.pojo.model.MachineServiceStatusEntity;
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
 * Created by kueihenglu on 2018/3/31.
 */
public class MachineServiceStatusDAO {
    public static Logger log = LoggerFactory.getLogger(MachineServiceStatusDAO.class);

    public List<MachineServiceStatusEntity> getMachineServiceStatusList(String machineName, String ipAddress,
                                                                        String machineType, String site,
                                                                        String status, String sortField, String sortType) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<MachineServiceStatusEntity> machineServiceStatusList = new LinkedList<MachineServiceStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[Machine_Service_status] WHERE 1=1 AND site = '" + site + "' ");

        if (!machineName.equals("")) {
            sqlstr.append(" AND machine_name = ?");
        }
        if (!ipAddress.equals("")) {
            sqlstr.append(" AND ip_address = ?");
        }
        if (!machineType.equals("")) {
            sqlstr.append(" AND machine_type = ?");
        }
        if (!status.equals("")) {
            sqlstr.append(" AND status = ?");
        }

        if (!sortField.equals("")) {
            sqlstr.append(" ORDER BY " + sortField);
        }
        if (!sortType.equals("")) {
            sqlstr.append(" " + sortType);
        }


        try {

            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());

            int groupParam = 0;
            if (!machineName.equals("")) {
                sqlQuery.setString(groupParam++, machineName);
            }
            if (!ipAddress.equals("")) {
                sqlQuery.setString(groupParam++, ipAddress);
            }
            if (!machineType.equals("")) {
                sqlQuery.setString(groupParam++, machineType);
            }
            if (!status.equals("")) {
                sqlQuery.setString(groupParam++, status);
            }


            try {
                resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                        .addScalar("machine_name", StandardBasicTypes.STRING)
                        .addScalar("ip_address", StandardBasicTypes.STRING)
                        .addScalar("machine_type", StandardBasicTypes.STRING)
                        .addScalar("status", StandardBasicTypes.STRING)
                        .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                        .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                        .list();
            } catch (Exception e) {
                log.error("取得搜尋機服務資訊發生錯誤：", e);
            }

            for (int i = 0; i < resultList.size(); i++) {

                MachineServiceStatusEntity machineServiceStatusEntity = new MachineServiceStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                machineServiceStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                machineServiceStatusEntity.setMachineName(String.valueOf(aResult[1]));
                machineServiceStatusEntity.setIpAddress(String.valueOf(aResult[2]));
                machineServiceStatusEntity.setMachineType(String.valueOf(aResult[3]));
                machineServiceStatusEntity.setStatus(String.valueOf(aResult[4]));
                machineServiceStatusEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                machineServiceStatusEntity.setUpdateTime(Timestamp.valueOf(String.valueOf(aResult[6])));

                machineServiceStatusList.add(machineServiceStatusEntity);

            }
            tx.commit();
        } catch (HibernateException e) {
            log.error("MachineServiceStatusDAO.getMachineServiceStatusList 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (Exception e) {
            log.error("MachineServiceStatusDAO.getMachineServiceStatusList 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return machineServiceStatusList;
    }
}
