package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class IndexTaskInformationEntity {
    private int id;
    private String indexName;
    private String indexType;
    private String actionFlag;
    private String status;
    private Timestamp lastBuildTime;
    private Integer buildSecond;
    private Long size;
    private Long records;
    private Timestamp updateTime;

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

    public String getIndexType() {
        return indexType;
    }

    public void setIndexType(String indexType) {
        this.indexType = indexType;
    }

    public String getActionFlag() {
        return actionFlag;
    }

    public void setActionFlag(String actionFlag) {
        this.actionFlag = actionFlag;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getLastBuildTime() {
        return lastBuildTime;
    }

    public void setLastBuildTime(Timestamp lastBuildTime) {
        this.lastBuildTime = lastBuildTime;
    }

    public Integer getBuildSecond() {
        return buildSecond;
    }

    public void setBuildSecond(Integer buildSecond) {
        this.buildSecond = buildSecond;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public Long getRecords() {
        return records;
    }

    public void setRecords(Long records) {
        this.records = records;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        IndexTaskInformationEntity that = (IndexTaskInformationEntity) o;

        if (id != that.id)
            return false;
        if (actionFlag != null ? !actionFlag.equals(that.actionFlag) : that.actionFlag != null)
            return false;
        if (buildSecond != null ? !buildSecond.equals(that.buildSecond) : that.buildSecond != null)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (indexType != null ? !indexType.equals(that.indexType) : that.indexType != null)
            return false;
        if (lastBuildTime != null ? !lastBuildTime.equals(that.lastBuildTime) : that.lastBuildTime != null)
            return false;
        if (records != null ? !records.equals(that.records) : that.records != null)
            return false;
        if (size != null ? !size.equals(that.size) : that.size != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (indexType != null ? indexType.hashCode() : 0);
        result = 31 * result + (actionFlag != null ? actionFlag.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (lastBuildTime != null ? lastBuildTime.hashCode() : 0);
        result = 31 * result + (buildSecond != null ? buildSecond.hashCode() : 0);
        result = 31 * result + (size != null ? size.hashCode() : 0);
        result = 31 * result + (records != null ? records.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        return result;
    }
}
