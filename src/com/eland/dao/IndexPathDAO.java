package com.eland.dao;

import com.eland.pojo.model.VwSwitchStatusEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/3/19.
 */
public class IndexPathDAO {
    //查詢今日切換狀況
    public List<VwSwitchStatusEntity> selectIndexPath() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        VwSwitchStatusEntity failQuery = new VwSwitchStatusEntity();
        failQuery.setMachineName("FailQuery");
        List<VwSwitchStatusEntity> result = new LinkedList<VwSwitchStatusEntity>();
        //result.add(failQuery);
        try {
            result = session.createQuery("FROM VwSwitchStatusEntity ")
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
