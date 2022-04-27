package com.eland.pojo.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "vw_index_custom_information", schema = "dbo", catalog = "opview_task")
public class VwIndexCustomInformationEntity {
    private int id;
    private String indexName;
    private String status;
    private Timestamp startTime;
    private Timestamp finishTime;
    private String buildMillisecond;
    private String size;
    private String records;
    private Integer pid;
    private String copyMachineName;
    private String copyStatus;


    @Id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "index_name", nullable = false, length = 50)
    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    @Basic
    @Column(name = "status", nullable = false, length = 50)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Basic
    @Column(name = "start_time", nullable = true)
    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    @Basic
    @Column(name = "finish_time", nullable = true)
    public Timestamp getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Timestamp finishTime) {
        this.finishTime = finishTime;
    }

    @Basic
    @Column(name = "build_millisecond", nullable = true, length = 100)
    public String getBuildMillisecond() {
        return buildMillisecond;
    }

    public void setBuildMillisecond(String buildMillisecond) {
        this.buildMillisecond = buildMillisecond;
    }

    @Basic
    @Column(name = "size", nullable = true, length = 100)
    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    @Basic
    @Column(name = "records", nullable = true, length = 100)
    public String getRecords() {
        return records;
    }

    public void setRecords(String records) {
        this.records = records;
    }

    @Basic
    @Column(name = "pid", nullable = true)
    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    @Basic
    @Column(name = "copy_machine_name", nullable = true, length = 50)
    public String getCopyMachineName() {
        return copyMachineName;
    }

    public void setCopyMachineName(String copyMachineName) {
        this.copyMachineName = copyMachineName;
    }

    @Basic
    @Column(name = "copy_status", nullable = true, length = 50)
    public String getCopyStatus() {
        return copyStatus;
    }

    public void setCopyStatus(String copyStatus) {
        this.copyStatus = copyStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        VwIndexCustomInformationEntity that = (VwIndexCustomInformationEntity) o;
        return id == that.id &&
                Objects.equals(indexName, that.indexName) &&
                Objects.equals(status, that.status) &&
                Objects.equals(startTime, that.startTime) &&
                Objects.equals(finishTime, that.finishTime) &&
                Objects.equals(buildMillisecond, that.buildMillisecond) &&
                Objects.equals(size, that.size) &&
                Objects.equals(records, that.records) &&
                Objects.equals(pid, that.pid) &&
                Objects.equals(copyMachineName, that.copyMachineName) &&
                Objects.equals(copyStatus, that.copyStatus);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, indexName, status, startTime, finishTime, buildMillisecond, size, records, pid, copyMachineName, copyStatus);
    }
}
