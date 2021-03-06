package com.eland.dao;

import com.eland.pojo.model.IncrementalIndexStatusLogEntity;
import com.eland.pojo.model.IndexInspectorStatusEntity;
import com.eland.pojo.model.IndexLogEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.apache.log4j.Logger;
import org.hibernate.*;
import org.hibernate.type.StandardBasicTypes;

import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;

public class TestDAO {
    //  private static Logger log = Logger.getLogger("Log");
    public List<IndexInspectorStatusEntity> selectList(String indexName, String site, String status, String indexType, String sortField, String sortType) {
        List<IndexInspectorStatusEntity> indexInspectorStatusList = new LinkedList<IndexInspectorStatusEntity>();
     /*   Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();

        StringBuffer sqlstr = new StringBuffer();
        sqlstr.append(
                "SELECT TOP 1000 * FROM [opview_task].[dbo].[index_inspector_status] WHERE 1=1 ");

                */

/*
        if (!indexName.equals("")) {
            sqlstr.append(
                    " AND index_name like ?");
        }
        if (!site.equals("")) {
            sqlstr.append(" AND site = ?");
        }
        if (!indexType.equals("")) {
            sqlstr.append(" AND index_type = ?");
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
*/
        //  System.out.println("sql:"+sqlstr);
/*
        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());

            int groupParam = 0;
            if (!indexName.equals("")) {
                sqlQuery.setString(groupParam++, "%"+indexName+"%");
            }
            if (!site.equals("")) {
                sqlQuery.setString(groupParam++, site);
            }
            if (!indexType.equals("")) {
                sqlQuery.setString(groupParam++, indexType);
            }
            if (!status.equals("")) {
                sqlQuery.setString(groupParam++, status);
            }*/

/*
        try {
            resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                    .addScalar("index_name", StandardBasicTypes.STRING)
                    .addScalar("site", StandardBasicTypes.STRING)
                    .addScalar("index_type", StandardBasicTypes.STRING)
                    .addScalar("last_post_time", StandardBasicTypes.STRING)
                    .addScalar("update_time", StandardBasicTypes.TIMESTAMP)
                    .addScalar("status", StandardBasicTypes.STRING)
                    .addScalar("issue_type", StandardBasicTypes.STRING)
                    .addScalar("repair_status", StandardBasicTypes.STRING)
                    .list();
        } catch (Exception e) {
            log.error("???????????????????????????????????????", e);
        }
        IndexInspectorStatusEntity incrementalIndexStatusLogEntity =new IndexInspectorStatusEntity();

        for (int i = 0; i < resultList.size(); i++) {
            incrementalIndexStatusLogEntity =new IndexInspectorStatusEntity();
            Object[] aResult = (Object[]) resultList.get(i);
            incrementalIndexStatusLogEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
            incrementalIndexStatusLogEntity.setIndexName(String.valueOf(aResult[1]));
            incrementalIndexStatusLogEntity.setSite(String.valueOf(aResult[2]));
            incrementalIndexStatusLogEntity.setIssueType(String.valueOf(aResult[3]));
            incrementalIndexStatusLogEntity.setLastPostTime(String.valueOf(aResult[4]));
            incrementalIndexStatusLogEntity.setUpdateTime(String.valueOf(String.valueOf(aResult[5])));
            incrementalIndexStatusLogEntity.setStatus(String.valueOf(aResult[6]));
            incrementalIndexStatusLogEntity.setIssueType(String.valueOf(aResult[7]));
            incrementalIndexStatusLogEntity.setRepairStatus(String.valueOf(aResult[8]));

            indexInspectorStatusList.add(incrementalIndexStatusLogEntity);

        }
        tx.commit();
    } catch (HibernateException e) {
        log.error("IncrementalIndexStatusLogDAO.getIncrementalStatusLogList ???????????????", e);
        System.out.println(e.getMessage());
        tx.rollback();
    } catch (Exception e) {
        log.error("IncrementalIndexStatusLogDAO.getIncrementalStatusLogList ???????????????", e);
        System.out.println(e.getMessage());
        tx.rollback();
    } finally {
        session.close();
    }
    */

        return indexInspectorStatusList;
    }


}
