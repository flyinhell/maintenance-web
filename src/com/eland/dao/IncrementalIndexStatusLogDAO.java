package com.eland.dao;

import com.eland.pojo.model.IncrementalIndexStatusEntity;
import com.eland.pojo.model.IncrementalIndexStatusLogEntity;
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
public class IncrementalIndexStatusLogDAO {
    public static Logger log = LoggerFactory.getLogger(IncrementalIndexStatusLogDAO.class);

    /**
     * 取得incremental_index_status_log中的row data
     *
     * @param indexName   [index_name]
     * @param machineName [machine_name]
     * @param status      [status]
     * @param type        [type]
     * @param sortField   排序欄位
     * @param sortType    排序方式
     * @return IncrementalIndexStatusLogEntity
     */
    public List<IncrementalIndexStatusLogEntity> getIncrementalStatusLogList(String indexName, String machineName, String status, String type, String sortField, String sortType, int record, String temp, String startTime, String endTime) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        List resultList = new LinkedList();
        List<IncrementalIndexStatusLogEntity> incrementalLogList = new LinkedList<IncrementalIndexStatusLogEntity>();

        StringBuffer sqlstr = new StringBuffer();
        sqlstr.append(
                "SELECT TOP " + record + " * FROM [opview_task].[dbo].[incremental_index_status_log] WHERE 1=1 ");

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
        if (!startTime.equals("")) {
            sqlstr.append(" AND start_time >= ?");
        }
        if (!endTime.equals("")) {
            sqlstr.append(" AND start_time <= ?");
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
            if (!startTime.equals("")) {
                sqlQuery.setString(groupParam++, startTime);
            }
            if (!endTime.equals("")) {
                sqlQuery.setString(groupParam++, endTime);
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

                IncrementalIndexStatusLogEntity incrementalIndexStatusLogEntity = new IncrementalIndexStatusLogEntity();
                Object[] aResult = (Object[]) resultList.get(i);

                incrementalIndexStatusLogEntity.setId(Integer.parseInt(String.valueOf(aResult[0])));
                incrementalIndexStatusLogEntity.setIndexName(String.valueOf(aResult[1]));
                incrementalIndexStatusLogEntity.setMachineName(String.valueOf(aResult[2]));
                incrementalIndexStatusLogEntity.setStatus(String.valueOf(aResult[3]));
                incrementalIndexStatusLogEntity.setStartTime(Timestamp.valueOf(String.valueOf(aResult[4])));
                if (String.valueOf(aResult[5]) == null || String.valueOf(aResult[5]).equals("null")) {
                    //incrementalIndexStatusEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                } else {
                    incrementalIndexStatusLogEntity.setFinishTime(Timestamp.valueOf(String.valueOf(aResult[5])));
                }
                if (String.valueOf(aResult[6]) == null || String.valueOf(aResult[6]).equals("null")) {

                } else {
                    incrementalIndexStatusLogEntity.setLastContentCreateTime(Timestamp.valueOf(String.valueOf(aResult[6])));
                }
                incrementalIndexStatusLogEntity.setRecords(Integer.parseInt(String.valueOf(aResult[7])));
                incrementalIndexStatusLogEntity.setType(String.valueOf(aResult[8]));

                incrementalLogList.add(incrementalIndexStatusLogEntity);

            }
            tx.commit();
        } catch (HibernateException e) {
            log.error("IncrementalIndexStatusLogDAO.getIncrementalStatusLogList 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } catch (Exception e) {
            log.error("IncrementalIndexStatusLogDAO.getIncrementalStatusLogList 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }

        return incrementalLogList;
    }

    public List<IncrementalIndexStatusLogEntity> selectDistinctIndexName(String todayOrInstant) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        IncrementalIndexStatusLogEntity incrementalIndexStatusLogEntity = new IncrementalIndexStatusLogEntity();
        List<IncrementalIndexStatusLogEntity> resultList = new LinkedList();
        resultList.add(incrementalIndexStatusLogEntity);
        try {
            resultList = session.createQuery("select distinct indexName from IncrementalIndexStatusLogEntity where indexName not like '%Temp%' and indexName like ?")
                    .setString(0, "%" + todayOrInstant + "%")
                    .list();
            tx.commit();
        } catch (Exception e) {
            log.error("IncrementalIndexStatusLogDAO.selectDistinctIndexName 發生錯誤：", e);
            System.out.println(e.getMessage());
            tx.rollback();
        } finally {
            session.close();
        }
        return resultList;
    }
}
