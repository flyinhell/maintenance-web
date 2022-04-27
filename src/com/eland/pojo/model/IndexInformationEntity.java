package com.eland.pojo.model;

/**
 * Created by ccyang on 2018/11/28.
 */
public class IndexInformationEntity {
    private int id;
    private String indexName;
    private String indexType;
    private String dateRange;
    private String databaseType;
    private String databaseAddress;
    private String viewName;
    private String pType2;

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

    public String getIndexType() {
        return indexType;
    }

    public void setIndexType(String indexType) {
        this.indexType = indexType;
    }

    public String getDateRange() {
        return dateRange;
    }

    public void setDateRange(String dateRange) {
        this.dateRange = dateRange;
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

    public String getpType2() {
        return pType2;
    }

    public void setpType2(String pType2) {
        this.pType2 = pType2;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        IndexInformationEntity that = (IndexInformationEntity) o;

        if (id != that.id)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (indexType != null ? !indexType.equals(that.indexType) : that.indexType != null)
            return false;
        if (dateRange != null ? !dateRange.equals(that.dateRange) : that.dateRange != null)
            return false;
        if (databaseType != null ? !databaseType.equals(that.databaseType) : that.databaseType != null)
            return false;
        if (databaseAddress != null ? !databaseAddress.equals(that.databaseAddress) : that.databaseAddress != null)
            return false;
        if (viewName != null ? !viewName.equals(that.viewName) : that.viewName != null)
            return false;
        if (pType2 != null ? !pType2.equals(that.pType2) : that.pType2 != null)
            return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (indexType != null ? indexType.hashCode() : 0);
        result = 31 * result + (dateRange != null ? dateRange.hashCode() : 0);
        result = 31 * result + (databaseType != null ? databaseType.hashCode() : 0);
        result = 31 * result + (databaseAddress != null ? databaseAddress.hashCode() : 0);
        result = 31 * result + (viewName != null ? viewName.hashCode() : 0);
        result = 31 * result + (pType2 != null ? pType2.hashCode() : 0);
        return result;
    }
}
