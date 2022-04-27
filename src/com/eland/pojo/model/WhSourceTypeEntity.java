package com.eland.pojo.model;

import javax.persistence.*;

@Entity
//@Table(name = "wh_source_type_dev", schema = "wh_query", catalog = "")
public class WhSourceTypeEntity {
    private String sourceId;
    private String sourceName;
    private String pType;
    private String pType2;

    @Id
    // @Column(name = "source_id", nullable = false, length = 32)
    public String getSourceId() {
        return sourceId;
    }

    public void setSourceId(String sourceId) {
        this.sourceId = sourceId;
    }

    @Basic
    //  @Column(name = "source_name", nullable = false, length = 100)
    public String getSourceName() {
        return sourceName;
    }

    public void setSourceName(String sourceName) {
        this.sourceName = sourceName;
    }

    @Basic
    // @Column(name = "p_type", nullable = false, length = 45)
    public String getpType() {
        return pType;
    }

    public void setpType(String pType) {
        this.pType = pType;
    }

    @Basic
    // @Column(name = "p_type_2", nullable = false, length = 45)
    public String getpType2() {
        return pType2;
    }

    public void setpType2(String pType2) {
        this.pType2 = pType2;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        WhSourceTypeEntity that = (WhSourceTypeEntity) o;

        if (sourceId != null ? !sourceId.equals(that.sourceId) : that.sourceId != null) return false;
        if (sourceName != null ? !sourceName.equals(that.sourceName) : that.sourceName != null) return false;
        if (pType != null ? !pType.equals(that.pType) : that.pType != null) return false;
        if (pType2 != null ? !pType2.equals(that.pType2) : that.pType2 != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = sourceId != null ? sourceId.hashCode() : 0;
        result = 31 * result + (sourceName != null ? sourceName.hashCode() : 0);
        result = 31 * result + (pType != null ? pType.hashCode() : 0);
        result = 31 * result + (pType2 != null ? pType2.hashCode() : 0);
        return result;
    }
}
