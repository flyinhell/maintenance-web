package com.eland.pojo.model;

/**
 * Created by ccyang on 2018/11/28.
 */
public class IndexInspectorConfigEntity {
    private int id;
    private String indexName;
    private String indexType;
    private String immediate;
    private String inspectSwitch;
    private String checkImmediateSql;

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

    public String getImmediate() {
        return immediate;
    }

    public void setImmediate(String immediate) {
        this.immediate = immediate;
    }

    public String getInspectSwitch() {
        return inspectSwitch;
    }

    public void setInspectSwitch(String inspectSwitch) {
        this.inspectSwitch = inspectSwitch;
    }

    public String getCheckImmediateSql() {
        return checkImmediateSql;
    }

    public void setCheckImmediateSql(String checkImmediateSql) {
        this.checkImmediateSql = checkImmediateSql;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        IndexInspectorConfigEntity that = (IndexInspectorConfigEntity) o;

        if (id != that.id)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (indexType != null ? !indexType.equals(that.indexType) : that.indexType != null)
            return false;
        if (immediate != null ? !immediate.equals(that.immediate) : that.immediate != null)
            return false;
        if (inspectSwitch != null ? !inspectSwitch.equals(that.inspectSwitch) : that.inspectSwitch != null)
            return false;
        if (checkImmediateSql != null ? !checkImmediateSql.equals(that.checkImmediateSql) : that.checkImmediateSql != null)
            return false;
        return true;
    }
    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (indexType != null ? indexType.hashCode() : 0);
        result = 31 * result + (immediate != null ? immediate.hashCode() : 0);
        result = 31 * result + (inspectSwitch != null ? inspectSwitch.hashCode() : 0);
        result = 31 * result + (checkImmediateSql != null ? checkImmediateSql.hashCode() : 0);
        return result;
    }
}
