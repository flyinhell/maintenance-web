package com.eland.pojo.model;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class MonthyTaskConfigEntity {

    private int id;
    private String indexName;
    private String databaseType;
    private String databaseAddress;
    private String viewName;
    private String viewSchema;
    private String machineNameList;
    private String priority;
    private String module;
    private String indexType;
    private String customer;
    private String sourceType;
    private String contentType;

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

    public String getDatabaseType() {
        return databaseType;
    }

    public void setDatabaseType(String databaseType) {
        this.databaseType = databaseType;
    }

    public String getDatabaseAddress() {
        return databaseAddress;
    }

    public void setDatabaseAddress(String databaseAddress) {
        this.databaseAddress = databaseAddress;
    }

    public String getViewName() {
        return viewName;
    }

    public void setViewName(String viewName) {
        this.viewName = viewName;
    }

    public String getViewSchema() {
        return viewSchema;
    }

    public void setViewSchema(String viewSchema) {
        this.viewSchema = viewSchema;
    }

    public String getMachineNameList() {
        return machineNameList;
    }

    public void setMachineNameList(String machineNameList) {
        this.machineNameList = machineNameList;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getIndexType() {
        return indexType;
    }

    public void setIndexType(String indexType) {
        this.indexType = indexType;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getSourceType() {
        return sourceType;
    }

    public void setSourceType(String sourceType) {
        this.sourceType = sourceType;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        MonthyTaskConfigEntity that = (MonthyTaskConfigEntity) o;

        if (id != that.id)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (databaseType != null ? !databaseType.equals(that.databaseType) : that.databaseType != null)
            return false;
        if (databaseAddress != null ? !databaseAddress.equals(that.databaseAddress) : that.databaseAddress != null)
            return false;
        if (viewName != null ? !viewName.equals(that.viewName) : that.viewName != null)
            return false;
        if (viewSchema != null ? !viewSchema.equals(that.viewSchema) : that.viewSchema != null)
            return false;
        if (machineNameList != null ? !machineNameList.equals(that.machineNameList) : that.machineNameList != null)
            return false;
        if (priority != null ? !priority.equals(that.priority) : that.priority != null)
            return false;
        if (module != null ? !module.equals(that.module) : that.module != null)
            return false;
        if (indexType != null ? !indexType.equals(that.indexType) : that.indexType != null)
            return false;
        if (customer != null ? !customer.equals(that.customer) : that.customer != null)
            return false;
        if (sourceType != null ? !sourceType.equals(that.sourceType) : that.sourceType != null)
            return false;
        if (contentType != null ? !contentType.equals(that.contentType) : that.contentType != null)
            return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (databaseType != null ? databaseType.hashCode() : 0);
        result = 31 * result + (databaseAddress != null ? databaseAddress.hashCode() : 0);
        result = 31 * result + (viewName != null ? viewName.hashCode() : 0);
        result = 31 * result + (viewSchema != null ? viewSchema.hashCode() : 0);
        result = 31 * result + (machineNameList != null ? machineNameList.hashCode() : 0);
        result = 31 * result + (priority != null ? priority.hashCode() : 0);
        result = 31 * result + (module != null ? module.hashCode() : 0);
        result = 31 * result + (indexType != null ? indexType.hashCode() : 0);
        result = 31 * result + (customer != null ? customer.hashCode() : 0);
        result = 31 * result + (sourceType != null ? sourceType.hashCode() : 0);
        result = 31 * result + (contentType != null ? contentType.hashCode() : 0);
        return result;
    }
}
