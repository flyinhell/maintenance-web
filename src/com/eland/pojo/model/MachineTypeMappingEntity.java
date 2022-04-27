package com.eland.pojo.model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by ccyang on 2018/8/10.
 */
@Entity
@Table(name = "machine_type_mapping", schema = "dbo", catalog = "opview_task")
public class MachineTypeMappingEntity {
    private int id;
    private String machineName;
    private String machineType;
    private String ipAddress;

    @Basic
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "machine_name", nullable = true, length = 64)
    public String getMachineName() {
        return machineName;
    }

    public void setMachineName(String machineName) {
        this.machineName = machineName;
    }

    @Basic
    @Column(name = "machine_type", nullable = true, length = 64)
    public String getMachineType() {
        return machineType;
    }

    public void setMachineType(String errorType) {
        this.machineType = errorType;
    }

    @Basic
    @Column(name = "ip_address", nullable = true, length = 64)
    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        MachineTypeMappingEntity that = (MachineTypeMappingEntity) o;
        if (id != that.id)
            return false;
        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (machineType != null ? !machineType.equals(that.machineType) : that.machineType != null)
            return false;
        if (ipAddress != null ? !ipAddress.equals(that.ipAddress) : that.ipAddress != null)
            return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (machineName != null ? machineName.hashCode() : 0);
        result = 31 * result + (machineType != null ? machineType.hashCode() : 0);
        result = 31 * result + (ipAddress != null ? ipAddress.hashCode() : 0);
        return result;
    }
}
