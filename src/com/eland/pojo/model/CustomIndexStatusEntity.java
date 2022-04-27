package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by zhenfu on 2020/5/7.
 */
public class CustomIndexStatusEntity {
    private int id;
    private int pid;
    private String indexName;
    private Timestamp startTime;
    private Timestamp finishTime;
    private String buildMillisecond;
    private String status;
    private String size;
    private String records;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Timestamp finishTime) {
        this.finishTime = finishTime;
    }

    public String getBuildMillisecond() {
        return buildMillisecond;
    }

    public void setBuildMillisecond(String buildMillisecond) {
        this.buildMillisecond = buildMillisecond;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getRecords() {
        return records;
    }

    public void setRecords(String records) {
        this.records = records;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        CustomIndexStatusEntity that = (CustomIndexStatusEntity) o;

        if (id != that.id)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (buildMillisecond != null ? !buildMillisecond.equals(that.buildMillisecond) : that.buildMillisecond != null)
            return false;
        if (startTime != null ? !startTime.equals(that.startTime) : that.startTime != null)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (records != null ? !records.equals(that.records) : that.records != null)
            return false;
        if (size != null ? !size.equals(that.size) : that.size != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (startTime != null ? startTime.hashCode() : 0);
        result = 31 * result + (buildMillisecond != null ? buildMillisecond.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (size != null ? size.hashCode() : 0);
        result = 31 * result + (records != null ? records.hashCode() : 0);
        return result;
    }
}
