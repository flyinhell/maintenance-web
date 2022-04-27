package com.eland.pojo.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "source_database_mapping", schema = "dbo", catalog = "opview_task")
public class SourceDatabaseMappingEntity {
    private int id;
    private String type;
    private String indexName;
    private String source;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "type", nullable = false, length = 100)
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Basic
    @Column(name = "index_name", nullable = false, length = 100)
    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    @Basic
    @Column(name = "source", nullable = false, length = 100)
    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SourceDatabaseMappingEntity that = (SourceDatabaseMappingEntity) o;
        return id == that.id &&
                Objects.equals(type, that.type) &&
                Objects.equals(indexName, that.indexName) &&
                Objects.equals(source, that.source);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, type, indexName, source);
    }
}
