package com.eland.dao;

import com.eland.pojo.model.IncrementalIndexStatusEntity;
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
 * Created by johnnyhuang on 2018/3/7.
 */
public class IncrementalIndexStatusDAO {
    public static Logger log = LoggerFactory.getLogger(IncrementalIndexStatusDAO.class);
    public static List<String> todayIndex = selectDistinctIndexName("today");
    public static List<String> instantIndex = selectDistinctIndexName("instant");

    /**
     * 取得incremental_index_status中的row data
     *
     * @param indexName   [index_name]
     * @param machineName [machine_name]
     * @param status      [status]
     * @param type        [type]
     * @param sortField   排序欄位
     * @param sortType    排序方式
     * @return IncrementalIndexStatusEntity
     */
    public List<IncrementalIndexStatusEntity> getIncrementalStatusList(String indexName, String machineName,
                                                                       String status, String type, String sortField,
                                                                       String sortType, String temp) {

        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IncrementalIndexStatusEntity> incrementalStatusList = new LinkedList<IncrementalIndexStatusEntity>();
        StringBuffer sqlstr = new StringBuffer();
        sqlstr.append(
                "SELECT * FROM [opview_task].[dbo].[incremental_index_status] WHERE 1=1 ");

        if (temp.equals("true")) {
            if (!indexName.equals("")) {
                sqlstr.append(" AND index_name like ? AND index_name not like '%temp%'");
            } else {
                sqlstr.append(" AND index_name not like '%temp%'");
            }
        } else {
            if (!indexName.equals("")) {
                sqlstr.append(" AND index_name like ?");
            }
        }

        if (!machineName.equals("")) {
            if (machineName.equals("standard") || machineName.equals("staff-only") || machineName.equals("advanced")) {
                sqlstr.append(" AND machine_name in (SELECT machine_name FROM [opview_task].[dbo].[machine_type_mapping] WHERE machine_type = '")
                        .append(machineName).append("')");
            } else if (machineName.equals("instant")) {
                sqlstr.append(" AND machine_name like '%in-searcher%'");
            } else {
                sqlstr.append(" AND machine_name = ?");
            }
        }
        if (!status.equals("")) {
            sqlstr.append(" AND status = ?");
        }
        if (!type.equals("")) {
            sqlstr.append(" AND type = ?");
        }

        if (!sortField.equals("")) {
            sqlstr.append(" ORDER BY " + sortField);
        }
        if (!sortType.equals("")) {
            sqlstr.append(" " + sortType);
        }

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
//            System.out.println(sqlstr.toString());

            int groupParam = 0;
            if (!indexName.equals("")) {
                sqlQuery.setString(groupParam++, "%" + indexName + "%");
            }
            if (machineName.contains("swd") || machineName.contains("so") || machineName.contains("in")) {
                sqlQuery.setString(groupParam++, machineName);
            }
            if (!status.equals("")) {
                sqlQuery.setString(groupParam++, status);
            }
            if (!type.equals("")) {
                sqlQuery.setString(groupParam++, type);
            }

            try {
                resultList = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
                        .addScalar("index_name", StandardBasicTypes.STRING)
                        .addScalar("machine_name", StandardBasicTypes.STRING)
                        .addScalar("status", StandardBasicTypes.STRING)
                        .addScalar("start_time", StandardBasicTypes.TIMESTAMP)
                        .addScalar("finish_time", StandardBasicTypes.TIMESTAMP)
                        .addScalar("last_content_create_time", StandardBasicTypes.TIMESTAMP)
                        .addScalar("records", StandardBasicTypes.INTEGER)
                        .addScalar("type", StandardBasicTypes.STRING)
                        .list();
            } catch (Exception e) {
                log.error("取得漸進索引資訊發生錯誤：", e);
            }

            for (int i = 0; i < resultList.size(); i++) {

                IncrementalIndexStatusEntity incrementalIndexStatusEntity = new IncrementalIndexStatusEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                incrementalIndexStatusEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                incrementalIndexStatusEntity.setIndexName(String.valueOf(aResult[1]));
                incrementalIndexStatusEntity.setMachineName(String.valueOf(aResult[2]));
                incrementalIndexStatusEntity.setStatus(String.valueOf(aResult[3]));
                incrementalIndexStatusEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[4])));
                if (String.valueOf(aResult[5]) == null || String.valueOf(aResult[5]).equals("null")) {
                    //incrementalIndexStatusEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                } else {
                    incrementalIndexStatusEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                }
                incrementalIndexStatusEntity.setLastContentCreateTime(Timestamp.valueOf(String.valueOf(aResult[6])));
                incrementalIndexStatusEntity.setRecords(Integer.parseInt(String.valueOf(aResult[7])));
                incrementalIndexStatusEntity.setType(String.valueOf(aResult[8]));

                incrementalStatusList.add(incrementalIndexStatusEntity);

            }
            tx.commit();
        } catch (HibernateException e) {
            log.error("IncrementalIndexStatusDAO.getIncrementalStatusList 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (Exception e) {
            log.error("IncrementalIndexStatusDAO.getIncrementalStatusList 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return incrementalStatusList;
    }

    //修改未完成的incremental狀態為fail
    public void updateStatus(String indexName, String machineName, String temp, String type) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        StringBuffer sqlstr = new StringBuffer();

        sqlstr.append("UPDATE [opview_task].[dbo].[incremental_index_status] SET status='Fail' WHERE 1=1");
        if (temp.equals("true")) {
            if (!indexName.equals("")) {
                sqlstr.append(" AND index_name like ? AND index_name not like '%temp%'");
            } else {
                sqlstr.append(" AND index_name not like '%temp%'");
            }
        } else {
            if (!indexName.equals("")) {
                sqlstr.append(" AND index_name like ?");
            }
        }
        if (!machineName.equals("")) {
            if (machineName.equals("standard") || machineName.equals("staff-only") || machineName.equals("advanced")) {
                sqlstr.append(" AND machine_name in (SELECT machine_name FROM [opview_task].[dbo].[machine_type_mapping] WHERE machine_type = '")
                        .append(machineName).append("')");
            } else if (machineName.equals("instant")) {
                sqlstr.append(" AND machine_name like '%in-searcher%'");
            } else {
                sqlstr.append(" AND machine_name = ?");
            }
        }
        if (!type.equals("")) {
            sqlstr.append(" AND type = ?");
        }

        try {
            SQLQuery sqlQuery = session.createSQLQuery(sqlstr.toString());
            int groupParam = 0;
            if (!indexName.equals("")) {
                sqlQuery.setString(groupParam++, "%" + indexName + "%");
            }
            if (machineName.contains("swd") || machineName.contains("so") || machineName.contains("in")) {
                sqlQuery.setString(groupParam++, machineName);
            }
            if (!type.equals("")) {
                sqlQuery.setString(groupParam++, type);
            }
            sqlQuery.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            log.error("IncrementalIndexStatusDAO.updateStatus 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }
    }

    public static List<String> selectDistinctIndexName(String todayOrInstant) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IncrementalIndexStatusEntity incrementalIndexStatusEntity = new IncrementalIndexStatusEntity();
        List<String> resultList = new LinkedList();
        resultList.add(incrementalIndexStatusEntity.getIndexName());
        try {
            resultList = session.createQuery("select distinct indexName from IncrementalIndexStatusEntity where indexName not like '%Temp%' and indexName like ?")
                    .setString(0, "%" + todayOrInstant + "%")
                    .list();
            tx.commit();
        } catch (Exception e) {
            log.error("IncrementalIndexStatusDAO.selectDistinctIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }
        return resultList;
    }
}
