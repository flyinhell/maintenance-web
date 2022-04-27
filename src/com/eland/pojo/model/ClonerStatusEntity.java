package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class ClonerStatusEntity {
    private String machineName;
    private Integer pid;
    private String status;
    private Timestamp updateTime;
    private String switchCloseCloner;

    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public String getSwitchCloseCloner() {
        return switchCloseCloner;
    }

    public void setSwitchCloseCloner(String switchCloseCloner) {
        this.switchCloseCloner = switchCloseCloner;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        ClonerStatusEntity that = (ClonerStatusEntity) o;

        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (pid != null ? !pid.equals(that.pid) : that.pid != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (switchCloseCloner != null ? !switchCloseCloner.equals(that.switchCloseCloner) :
            that.switchCloseCloner != null)
            return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = machineName != null ? machineName.hashCode() : 0;
        result = 31 * result + (pid != null ? pid.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = 31 * result + (switchCloseCloner != null ? switchCloseCloner.hashCode() : 0);
        return result;
    }
}
