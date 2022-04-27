package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class IncrementalIndexStatusEntity {
    private int id;
    private String indexName;
    private String machineName;
    private String status;
    private Timestamp startTime;
    private Timestamp finishTime;
    private Timestamp lastContentCreateTime;
    private Integer records;
    private String type;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Timestamp getLastContentCreateTime() {
        return lastContentCreateTime;
    }

    public void setLastContentCreateTime(Timestamp lastContentCreateTime) {
        this.lastContentCreateTime = lastContentCreateTime;
    }

    public Integer getRecords() {
        return records;
    }

    public void setRecords(Integer records) {
        this.records = records;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        IncrementalIndexStatusEntity that = (IncrementalIndexStatusEntity) o;

        if (id != that.id)
            return false;
        if (finishTime != null ? !finishTime.equals(that.finishTime) : that.finishTime != null)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (lastContentCreateTime != null ? !lastContentCreateTime.equals(that.lastContentCreateTime) :
            that.lastContentCreateTime != null)
            return false;
        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (records != null ? !records.equals(that.records) : that.records != null)
            return false;
        if (startTime != null ? !startTime.equals(that.startTime) : that.startTime != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (type != null ? !type.equals(that.type) : that.type != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (machineName != null ? machineName.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (startTime != null ? startTime.hashCode() : 0);
        result = 31 * result + (finishTime != null ? finishTime.hashCode() : 0);
        result = 31 * result + (lastContentCreateTime != null ? lastContentCreateTime.hashCode() : 0);
        result = 31 * result + (records != null ? records.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        return result;
    }
}
