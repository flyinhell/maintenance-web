package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class TaskLogEntity {
    private int id;
    private String indexName;
    private String targetPath;
    private String actionFlag;
    private String status;
    private Timestamp taskStartTime;
    private Timestamp taskEndTime;

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

    public Timestamp getTaskStartTime() {
        return taskStartTime;
    }

    public void setTaskStartTime(Timestamp taskStartTime) {
        this.taskStartTime = taskStartTime;
    }

    public Timestamp getTaskEndTime() {
        return taskEndTime;
    }

    public void setTaskEndTime(Timestamp taskEndTime) {
        this.taskEndTime = taskEndTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        TaskLogEntity that = (TaskLogEntity) o;
        if (id != that.id)
            return false;
        if (actionFlag != null ? !actionFlag.equals(that.actionFlag) : that.actionFlag != null)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (targetPath != null ? !targetPath.equals(that.targetPath) : that.targetPath != null)
            return false;
        if (taskEndTime != null ? !taskEndTime.equals(that.taskEndTime) : that.taskEndTime != null)
            return false;
        if (taskStartTime != null ? !taskStartTime.equals(that.taskStartTime) : that.taskStartTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        //result = indexName != null ? indexName.hashCode() : 0;
        result = id;
        result = 31 * result + (targetPath != null ? targetPath.hashCode() : 0);
        result = 31 * result + (actionFlag != null ? actionFlag.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (taskStartTime != null ? taskStartTime.hashCode() : 0);
        result = 31 * result + (taskEndTime != null ? taskEndTime.hashCode() : 0);
        return result;
    }
}
