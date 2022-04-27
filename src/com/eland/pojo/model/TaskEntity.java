package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class TaskEntity {
    private int id;
    private String machineName;
    private String indexName;
    private String targetPath;
    private String actionFlag;
    private String status;
    private Timestamp taskTime;
    private Integer machineWeight;
    private Integer indexWeight;
    private Integer errorNum;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
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

    public Timestamp getTaskTime() {
        return taskTime;
    }

    public void setTaskTime(Timestamp taskTime) {
        this.taskTime = taskTime;
    }

    public Integer getMachineWeight() {
        return machineWeight;
    }

    public void setMachineWeight(Integer machineWeight) {
        this.machineWeight = machineWeight;
    }

    public Integer getIndexWeight() {
        return indexWeight;
    }

    public void setIndexWeight(Integer indexWeight) {
        this.indexWeight = indexWeight;
    }

    public Integer getErrorNum() {
        return errorNum;
    }

    public void setErrorNum(Integer errorNum) {
        this.errorNum = errorNum;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        TaskEntity that = (TaskEntity) o;

        if (id != that.id)
            return false;
        if (actionFlag != null ? !actionFlag.equals(that.actionFlag) : that.actionFlag != null)
            return false;
        if (errorNum != null ? !errorNum.equals(that.errorNum) : that.errorNum != null)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (indexWeight != null ? !indexWeight.equals(that.indexWeight) : that.indexWeight != null)
            return false;
        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (machineWeight != null ? !machineWeight.equals(that.machineWeight) : that.machineWeight != null)
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
        int result = id;
        result = 31 * result + (machineName != null ? machineName.hashCode() : 0);
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (targetPath != null ? targetPath.hashCode() : 0);
        result = 31 * result + (actionFlag != null ? actionFlag.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (taskTime != null ? taskTime.hashCode() : 0);
        result = 31 * result + (machineWeight != null ? machineWeight.hashCode() : 0);
        result = 31 * result + (indexWeight != null ? indexWeight.hashCode() : 0);
        result = 31 * result + (errorNum != null ? errorNum.hashCode() : 0);
        return result;
    }
}
