package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class VwClonerStatusEntity {
    private String clonerMachine;
    private Integer pid;
    private String processStatus;
    private Timestamp updateTime;
    private Timestamp lastFinishTaskTime;
    private Integer min;
    private String status;

    public String getClonerMachine() {
        return clonerMachine;
    }

    public void setClonerMachine(String clonerMachine) {
        this.clonerMachine = clonerMachine;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getProcessStatus() {
        return processStatus;
    }

    public void setProcessStatus(String processStatus) {
        this.processStatus = processStatus;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public Timestamp getLastFinishTaskTime() {
        return lastFinishTaskTime;
    }

    public void setLastFinishTaskTime(Timestamp lastFinishTaskTime) {
        this.lastFinishTaskTime = lastFinishTaskTime;
    }

    public Integer getMin() {
        return min;
    }

    public void setMin(Integer min) {
        this.min = min;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        VwClonerStatusEntity that = (VwClonerStatusEntity) o;

        if (clonerMachine != null ? !clonerMachine.equals(that.clonerMachine) : that.clonerMachine != null)
            return false;
        if (lastFinishTaskTime != null ? !lastFinishTaskTime.equals(that.lastFinishTaskTime) :
            that.lastFinishTaskTime != null)
            return false;
        if (min != null ? !min.equals(that.min) : that.min != null)
            return false;
        if (pid != null ? !pid.equals(that.pid) : that.pid != null)
            return false;
        if (processStatus != null ? !processStatus.equals(that.processStatus) : that.processStatus != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = clonerMachine != null ? clonerMachine.hashCode() : 0;
        result = 31 * result + (pid != null ? pid.hashCode() : 0);
        result = 31 * result + (processStatus != null ? processStatus.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = 31 * result + (lastFinishTaskTime != null ? lastFinishTaskTime.hashCode() : 0);
        result = 31 * result + (min != null ? min.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }
}
