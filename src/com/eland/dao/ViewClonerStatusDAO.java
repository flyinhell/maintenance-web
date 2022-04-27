package com.eland.dao;

import com.eland.pojo.model.VwClonerStatusEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ccyang on 2018/3/19.
 */
public class ViewClonerStatusDAO {
    //檢查各機器cloner狀況
    public List<VwClonerStatusEntity> selectClonerStatus() {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        VwClonerStatusEntity failQuery = new VwClonerStatusEntity();
        failQuery.setClonerMachine("Fail Query");
        List<VwClonerStatusEntity> result = new LinkedList<VwClonerStatusEntity>();
        result.add(failQuery);
        try {
            result = session.createQuery("FROM VwClonerStatusEntity ORDER BY clonerMachine")
                    .list();
            tx.commit();

        } catch (Exception e) {
            tx.rollback();

        } finally {
            session.close();
        }
        return result;
    }

/*
ViewClonerStatusDAO	1.檢查各機器cloner狀況	"無
selectClonerStatus()"	SELECT  * FROM [opview_task].[dbo].[vw_cloner_status]
 */
}
