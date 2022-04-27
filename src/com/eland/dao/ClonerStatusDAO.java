package com.eland.dao;

import com.eland.pojo.model.ClonerStatusEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 * Created by ccyang on 2018/3/19.
 */
public class ClonerStatusDAO {
    private static Logger log = Logger.getLogger("Log");
    private String machineName;

    public void callCloseTools(String machineName) {
        log.info("Close cloner :" + machineName);
        if (machineName.equals("all")) {
            updateClonerStatus("%swd%");
        } else if (machineName.equals("allIndexer")) {
            updateClonerStatus("%indexer%");
        } else if (machineName.equals("allSearcher")) {
            updateClonerStatus("%searcher%");
        } else {
            updateClonerStatus("%" + machineName + "%");
        }
    }


    //關閉指定cloner
    public Boolean updateClonerStatus(String machineName) {
        boolean error = true;
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        try {
            List<ClonerStatusEntity> indexTaskInformationEntity = selectClonerStatus(machineName);
            for (ClonerStatusEntity clonerStatusEntity : indexTaskInformationEntity) {
                clonerStatusEntity.setSwitchCloseCloner("on");
                session.update(clonerStatusEntity);
            }
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            error = false;
            e.printStackTrace();
            log.info(e.getMessage());
        } finally {
            session.close();
        }

        return error;
    }

    //顯示機器cloner的狀況
    public List<ClonerStatusEntity> selectClonerStatus(String machineName) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        ClonerStatusEntity failQuery = new ClonerStatusEntity();
        failQuery.setMachineName("FailQuery");
        List<ClonerStatusEntity> result = new LinkedList<ClonerStatusEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM ClonerStatusEntity WHERE machineName like ?")
                    .setString(0, machineName)
                    .list();
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
        return result;
    }


}
