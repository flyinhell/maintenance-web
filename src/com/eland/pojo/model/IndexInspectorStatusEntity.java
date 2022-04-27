package com.eland.pojo.model;

/**
 * Created by ccyang on 2018/11/28.
 */
public class IndexInspectorStatusEntity {
    private int id;
    private String indexName;
    private String site;
    private String indexType;
    private String lastPostTime;
    private String updateTime;
    private String status;
    private String issueType;
    private String repairStatus;

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

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public String getIndexType() {
        return indexType;
    }

    public void setIndexType(String indexType) {
        this.indexType = indexType;
    }

    public String getLastPostTime() {
        return lastPostTime;
    }

    public void setLastPostTime(String lastPostTime) {
        this.lastPostTime = lastPostTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRepairStatus() {
        return repairStatus;
    }

    public void setRepairStatus(String repairStatus) {
        this.repairStatus = repairStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        IndexInspectorStatusEntity that = (IndexInspectorStatusEntity) o;

        if (id != that.id)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (site != null ? !site.equals(that.site) : that.site != null)
            return false;
        if (indexType != null ? !indexType.equals(that.indexType) : that.indexType != null)
            return false;
        if (lastPostTime != null ? !lastPostTime.equals(that.lastPostTime) : that.lastPostTime != null)
            return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (issueType != null ? !issueType.equals(that.issueType) : that.issueType != null)
            return false;
        if (repairStatus != null ? !repairStatus.equals(that.repairStatus) : that.repairStatus != null)
            return false;
        return true;
    }
    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (site != null ? site.hashCode() : 0);
        result = 31 * result + (indexType != null ? indexType.hashCode() : 0);
        result = 31 * result + (lastPostTime != null ? lastPostTime.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (issueType != null ? issueType.hashCode() : 0);
        result = 31 * result + (repairStatus != null ? repairStatus.hashCode() : 0);
        return result;
    }
}
