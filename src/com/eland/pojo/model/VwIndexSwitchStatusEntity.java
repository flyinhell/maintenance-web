package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class VwIndexSwitchStatusEntity {
    private int id;
    private String indexName;
    private String machineName;
    private String indexType;
    private String indexStatus;
    private String targetPath;
    private String actionFlag;
    private String status;
    private Timestamp lastBuildTime;
    private Timestamp taskTime;
    private String switchReady;

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

    public String getIndexType() {
        return indexType;
    }

    public void setIndexType(String indexType) {
        this.indexType = indexType;
    }

    public String getIndexStatus() {
        return indexStatus;
    }

    public void setIndexStatus(String indexStatus) {
        this.indexStatus = indexStatus;
    }

    public String getTargetPath() {
        return targetPath;
    }

    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
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

    public Timestamp getTaskTime() {
        return taskTime;
    }

    public void setTaskTime(Timestamp taskTime) {
        this.taskTime = taskTime;
    }

    public String getSwitchReady() {
        return switchReady;
    }

    public void setSwitchReady(String switchReady) {
        this.switchReady = switchReady;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        VwIndexSwitchStatusEntity that = (VwIndexSwitchStatusEntity) o;
        if (id != that.id)
            return false;
        if (actionFlag != null ? !actionFlag.equals(that.actionFlag) : that.actionFlag != null)
            return false;
        if (switchReady != null ? !switchReady.equals(that.switchReady) : that.switchReady != null)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (indexStatus != null ? !indexStatus.equals(that.indexStatus) : that.indexStatus != null)
            return false;
        if (indexType != null ? !indexType.equals(that.indexType) : that.indexType != null)
            return false;
        if (lastBuildTime != null ? !lastBuildTime.equals(that.lastBuildTime) : that.lastBuildTime != null)
            return false;
        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (targetPath != null ? !targetPath.equals(that.targetPath) : that.targetPath != null)
            return false;
        if (taskTime != null ? !taskTime.equals(that.taskTime) : that.taskTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result ;
        //int result = indexName != null ? indexName.hashCode() : 0;
        result = id;
        result = 31 * result + (machineName != null ? machineName.hashCode() : 0);
        result = 31 * result + (indexType != null ? indexType.hashCode() : 0);
        result = 31 * result + (indexStatus != null ? indexStatus.hashCode() : 0);
        result = 31 * result + (targetPath != null ? targetPath.hashCode() : 0);
        result = 31 * result + (actionFlag != null ? actionFlag.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (lastBuildTime != null ? lastBuildTime.hashCode() : 0);
        result = 31 * result + (taskTime != null ? taskTime.hashCode() : 0);
        result = 31 * result + (switchReady != null ? switchReady.hashCode() : 0);
        return result;
    }
}
