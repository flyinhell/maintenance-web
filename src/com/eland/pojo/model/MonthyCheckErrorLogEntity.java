package com.eland.pojo.model;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class MonthyCheckErrorLogEntity {

    private int id;
    private String indexName;
    private String machineName;
    private String errorType;
    private String errorTime;

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

    public String getErrorType() {
        return errorType;
    }

    public void setErrorType(String errorType) {
        this.errorType = errorType;
    }

    public String getErrorTime() {
        return errorTime;
    }

    public void setErrorTime(String errorTime) {
        this.errorTime = errorTime;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        MonthyCheckErrorLogEntity that = (MonthyCheckErrorLogEntity) o;

        if (id != that.id)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (errorType != null ? !errorType.equals(that.errorType) : that.errorType != null)
            return false;
        if (errorTime != null ? !errorTime.equals(that.errorTime) : that.errorTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (machineName != null ? machineName.hashCode() : 0);
        result = 31 * result + (errorType != null ? errorType.hashCode() : 0);
        result = 31 * result + (errorTime != null ? errorTime.hashCode() : 0);
        return result;
    }
}
