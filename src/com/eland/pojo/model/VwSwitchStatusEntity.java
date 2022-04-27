package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class VwSwitchStatusEntity {
    private String targetPath;
    private String machineName;
    private Timestamp taskTime;
    private Timestamp updateTime;
    private String lastSwitchDate;
    private String switchStatus;

    public String getTargetPath() {
        return targetPath;
    }

    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
    }

    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    public Timestamp getTaskTime() {
        return taskTime;
    }

    public void setTaskTime(Timestamp taskTime) {
        this.taskTime = taskTime;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public String getLastSwitchDate() {
        return lastSwitchDate;
    }

    public void setLastSwitchDate(String lastSwitchDate) {
        this.lastSwitchDate = lastSwitchDate;
    }

    public String getSwitchStatus() {
        return switchStatus;
    }

    public void setSwitchStatus(String switchStatus) {
        this.switchStatus = switchStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        VwSwitchStatusEntity that = (VwSwitchStatusEntity) o;

        if (lastSwitchDate != null ? !lastSwitchDate.equals(that.lastSwitchDate) : that.lastSwitchDate != null)
            return false;
        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (switchStatus != null ? !switchStatus.equals(that.switchStatus) : that.switchStatus != null)
            return false;
        if (targetPath != null ? !targetPath.equals(that.targetPath) : that.targetPath != null)
            return false;
        if (taskTime != null ? !taskTime.equals(that.taskTime) : that.taskTime != null)
            return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = targetPath != null ? targetPath.hashCode() : 0;
        result = 31 * result + (machineName != null ? machineName.hashCode() : 0);
        result = 31 * result + (taskTime != null ? taskTime.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = 31 * result + (lastSwitchDate != null ? lastSwitchDate.hashCode() : 0);
        result = 31 * result + (switchStatus != null ? switchStatus.hashCode() : 0);
        return result;
    }
}
