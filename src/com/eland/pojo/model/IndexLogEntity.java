package com.eland.pojo.model;

import java.sql.Timestamp;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class IndexLogEntity {
    private int id;
    private String actionType;
    private String host;
    private String indexdb;
    private String indexdbSize;
    private String indexdbRecnum;
    private String target;
    private Timestamp startTime;
    private Timestamp finishTime;
    private double duration;
    private String status;
    private Timestamp contentCreateTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getIndexdb() {
        return indexdb;
    }

    public void setIndexdb(String indexdb) {
        this.indexdb = indexdb;
    }

    public String getIndexdbSize() {
        return indexdbSize;
    }

    public void setIndexdbSize(String indexdbSize) {
        this.indexdbSize = indexdbSize;
    }

    public String getIndexdbRecnum() {
        return indexdbRecnum;
    }

    public void setIndexdbRecnum(String indexdbRecnum) {
        this.indexdbRecnum = indexdbRecnum;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Timestamp finishTime) {
        this.finishTime = finishTime;
    }

    public double getDuration() {
        return duration;
    }

    public void setDuration(double duration) {
        this.duration = duration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getContentCreateTime() {
        return contentCreateTime;
    }

    public void setContentCreateTime(Timestamp contentCreateTime) {
        this.contentCreateTime = contentCreateTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        IndexLogEntity that = (IndexLogEntity) o;

        if (Double.compare(that.duration, duration) != 0)
            return false;
        if (id != that.id)
            return false;
        if (actionType != null ? !actionType.equals(that.actionType) : that.actionType != null)
            return false;
        if (contentCreateTime != null ? !contentCreateTime.equals(that.contentCreateTime) :
            that.contentCreateTime != null)
            return false;
        if (finishTime != null ? !finishTime.equals(that.finishTime) : that.finishTime != null)
            return false;
        if (host != null ? !host.equals(that.host) : that.host != null)
            return false;
        if (indexdb != null ? !indexdb.equals(that.indexdb) : that.indexdb != null)
            return false;
        if (indexdbRecnum != null ? !indexdbRecnum.equals(that.indexdbRecnum) : that.indexdbRecnum != null)
            return false;
        if (indexdbSize != null ? !indexdbSize.equals(that.indexdbSize) : that.indexdbSize != null)
            return false;
        if (startTime != null ? !startTime.equals(that.startTime) : that.startTime != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null)
            return false;
        if (target != null ? !target.equals(that.target) : that.target != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = id;
        result = 31 * result + (actionType != null ? actionType.hashCode() : 0);
        result = 31 * result + (host != null ? host.hashCode() : 0);
        result = 31 * result + (indexdb != null ? indexdb.hashCode() : 0);
        result = 31 * result + (indexdbSize != null ? indexdbSize.hashCode() : 0);
        result = 31 * result + (indexdbRecnum != null ? indexdbRecnum.hashCode() : 0);
        result = 31 * result + (target != null ? target.hashCode() : 0);
        result = 31 * result + (startTime != null ? startTime.hashCode() : 0);
        result = 31 * result + (finishTime != null ? finishTime.hashCode() : 0);
        temp = Double.doubleToLongBits(duration);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (contentCreateTime != null ? contentCreateTime.hashCode() : 0);
        return result;
    }
}
