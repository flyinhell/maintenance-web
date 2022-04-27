package com.eland.dao;

import com.eland.pojo.model.MonthyCheckErrorLogEntity;
import com.eland.pojo.model.MonthyTaskCheckEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by kueihenglu on 2018/8/23.
 */
public class MonthyCheckErrorLogDAO {


    public List<MonthyCheckErrorLogEntity> selectMonthyCheckErrorLog(String startTime, String endTime) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        MonthyCheckErrorLogEntity failQuery = new MonthyCheckErrorLogEntity();
        failQuery.setId(-1);
        List<MonthyCheckErrorLogEntity> result = new LinkedList<MonthyCheckErrorLogEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM MonthyCheckErrorLogEntity where errorTime >='" + startTime + "' and errorTime <='" +
                    endTime + "' order by errorTime desc").setMaxResults(100).list();
        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }
}
