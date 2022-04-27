package com.eland.dao;

import com.eland.pojo.model.VwIndexSwitchStatusEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/3/19.
 */
public class SwitchStatusDAO {

    //尚未切換時，查詢未完成準備的索引清單
    public List<VwIndexSwitchStatusEntity> selectViewIndexSwitchStatus() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        VwIndexSwitchStatusEntity failQuery = new VwIndexSwitchStatusEntity();
        failQuery.setMachineName("FailQuery");
        List<VwIndexSwitchStatusEntity> result = new LinkedList<VwIndexSwitchStatusEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM VwIndexSwitchStatusEntity where switchReady = 'false' order by indexName asc ")
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
