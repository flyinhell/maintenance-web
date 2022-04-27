package com.eland.pojo.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "custom_index_copy_task", schema = "dbo", catalog = "opview_task")
public class CustomIndexCopyTaskEntity {
    private int id;
    private String machineName;
    private String indexName;
    private String targetPath;
    private String actionFlag;
    private String status;
    private Timestamp startTime;
    private Timestamp finishTime;
    private Integer pid;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "machine_name", nullable = true, length = 50)
    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    @Basic
    @Column(name = "index_name", nullable = true, length = 50)
    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    @Basic
    @Column(name = "target_path", nullable = true, length = 50)
    public String getTargetPath() {
        return targetPath;
    }

    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
    }

    @Basic
    @Column(name = "action_flag", nullable = true, length = 50)
    public String getActionFlag() {
        return actionFlag;
    }

    public void setActionFlag(String actionFlag) {
        this.actionFlag = actionFlag;
    }

    @Basic
    @Column(name = "status", nullable = true, length = 50)
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
    @Column(name = "pid", nullable = true)
    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomIndexCopyTaskEntity that = (CustomIndexCopyTaskEntity) o;
        return id == that.id && Objects.equals(machineName, that.machineName) && Objects.equals(indexName, that.indexName) && Objects.equals(targetPath, that.targetPath) && Objects.equals(actionFlag, that.actionFlag) && Objects.equals(status, that.status) && Objects.equals(startTime, that.startTime) && Objects.equals(finishTime, that.finishTime) && Objects.equals(pid, that.pid);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, machineName, indexName, targetPath, actionFlag, status, startTime, finishTime, pid);
    }
}
