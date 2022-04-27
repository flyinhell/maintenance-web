package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class ApiIndexStatusEntity {
    private int id;
    private String indexName;
    private Timestamp buildTime;
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

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public Timestamp getBuildTime() {
        return buildTime;
    }

    public void setBuildTime(Timestamp buildTime) {
        this.buildTime = buildTime;
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

        ApiIndexStatusEntity that = (ApiIndexStatusEntity) o;

        if (id != that.id)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (buildMillisecond != null ? !buildMillisecond.equals(that.buildMillisecond) : that.buildMillisecond != null)
            return false;
        if (buildTime != null ? !buildTime.equals(that.buildTime) : that.buildTime != null)
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
        result = 31 * result + (buildTime != null ? buildTime.hashCode() : 0);
        result = 31 * result + (buildMillisecond != null ? buildMillisecond.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (size != null ? size.hashCode() : 0);
        result = 31 * result + (records != null ? records.hashCode() : 0);
        return result;
    }
}
