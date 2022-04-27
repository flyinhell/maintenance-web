package com.eland.pojo.model;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class MonthyTaskMachineCheckEntity {

    private String machineName;
    private String p2pStatus;
    private String tspsdkStatus;
    private String updateTime;
    private String month;

    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    public String getP2pStatus() {
        return p2pStatus;
    }

    public void setP2pStatus(String p2pStatus) {
        this.p2pStatus = p2pStatus;
    }

    public String getTspsdkStatus() {
        return tspsdkStatus;
    }

    public void setTspsdkStatus(String tspsdkStatus) {
        this.tspsdkStatus = tspsdkStatus;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        MonthyTaskMachineCheckEntity that = (MonthyTaskMachineCheckEntity) o;


        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (p2pStatus != null ? !p2pStatus.equals(that.p2pStatus) : that.p2pStatus != null)
            return false;
        if (tspsdkStatus != null ? !tspsdkStatus.equals(that.tspsdkStatus) : that.tspsdkStatus != null)
            return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null)
            return false;
        if (month != null ? !month.equals(that.month) : that.month != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = machineName != null ? machineName.hashCode() : 0;
        result = 31 * result + (p2pStatus != null ? p2pStatus.hashCode() : 0);
        result = 31 * result + (tspsdkStatus != null ? tspsdkStatus.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = 31 * result + (month != null ? month.hashCode() : 0);
        return result;
    }
}
