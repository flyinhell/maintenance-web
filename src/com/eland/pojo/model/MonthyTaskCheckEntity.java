package com.eland.pojo.model;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class MonthyTaskCheckEntity {

    private String indexName;
    private String machineMappingStatus;
    private String sourceMappingStatus;
    private String p2pStatus;
    private String tempIndexStatus;
    private String tspsdkStatus;
    private String viewStatus;
    private String checkTime;
    private String month;

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public String getMachineMappingStatus() {
        return machineMappingStatus;
    }

    public void setMachineMappingStatus(String machineMappingStatus) {
        this.machineMappingStatus = machineMappingStatus;
    }

    public String getSourceMappingStatus() {
        return sourceMappingStatus;
    }

    public void setSourceMappingStatus(String souceMappingStatus) {
        this.sourceMappingStatus = souceMappingStatus;
    }

    public String getP2pStatus() {
        return p2pStatus;
    }

    public void setP2pStatus(String p2pStatus) {
        this.p2pStatus = p2pStatus;
    }

    public String getTempIndexStatus() {
        return tempIndexStatus;
    }

    public void setTempIndexStatus(String tempIndexStatus) {
        this.tempIndexStatus = tempIndexStatus;
    }

    public String getTspsdkStatus() {
        return tspsdkStatus;
    }

    public void setTspsdkStatus(String tspsdkStatus) {
        this.tspsdkStatus = tspsdkStatus;
    }

    public String getViewStatus() {
        return viewStatus;
    }

    public void setViewStatus(String viewStatus) {
        this.viewStatus = viewStatus;
    }

    public String getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(String checkTime) {
        this.checkTime = checkTime;
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

        MonthyTaskCheckEntity that = (MonthyTaskCheckEntity) o;

        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (machineMappingStatus != null ? !machineMappingStatus.equals(that.machineMappingStatus) : that.machineMappingStatus != null)
            return false;
        if (sourceMappingStatus != null ? !sourceMappingStatus.equals(that.sourceMappingStatus) : that.sourceMappingStatus != null)
            return false;
        if (p2pStatus != null ? !p2pStatus.equals(that.p2pStatus) : that.p2pStatus != null)
            return false;
        if (tempIndexStatus != null ? !tempIndexStatus.equals(that.tempIndexStatus) : that.tempIndexStatus != null)
            return false;
        if (tspsdkStatus != null ? !tspsdkStatus.equals(that.tspsdkStatus) : that.tspsdkStatus != null)
            return false;
        if (viewStatus != null ? !viewStatus.equals(that.viewStatus) : that.viewStatus != null)
            return false;
        if (checkTime != null ? !checkTime.equals(that.checkTime) : that.checkTime != null)
            return false;
        if (month != null ? !month.equals(that.month) : that.month != null)
            return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result = indexName != null ? indexName.hashCode() : 0;
        result = 31 * result + (machineMappingStatus != null ? machineMappingStatus.hashCode() : 0);
        result = 31 * result + (sourceMappingStatus != null ? sourceMappingStatus.hashCode() : 0);
        result = 31 * result + (p2pStatus != null ? p2pStatus.hashCode() : 0);
        result = 31 * result + (tempIndexStatus != null ? tempIndexStatus.hashCode() : 0);
        result = 31 * result + (tspsdkStatus != null ? tspsdkStatus.hashCode() : 0);
        result = 31 * result + (viewStatus != null ? viewStatus.hashCode() : 0);
        result = 31 * result + (checkTime != null ? checkTime.hashCode() : 0);
        result = 31 * result + (month != null ? month.hashCode() : 0);
        return result;
    }
}
