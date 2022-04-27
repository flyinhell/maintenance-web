package com.eland.pojo.model;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class IndexMachineMappingEntity {
    private int id;
    private String indexName;
    private String machineName;
    private int priority;
    private String module;

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

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        IndexMachineMappingEntity that = (IndexMachineMappingEntity) o;

        if (id != that.id)
            return false;
        if (priority != that.priority)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (machineName != null ? !machineName.equals(that.machineName) : that.machineName != null)
            return false;
        if (module != null ? !module.equals(that.module) : that.module != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (machineName != null ? machineName.hashCode() : 0);
        result = 31 * result + priority;
        result = 31 * result + (module != null ? module.hashCode() : 0);
        return result;
    }
}
