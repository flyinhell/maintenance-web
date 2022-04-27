package com.eland.pojo.model;

/**
 * Created by johnnyhuang on 2018/3/6.
 */
public class CustomIndexInformationEntity {
    private int id;
    private String indexName;
    private String minute;
    private String hour;
    private String day;
    private Integer timeoutSecond;

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

    public String getMinute() {
        return minute;
    }

    public void setMinute(String minute) {
        this.minute = minute;
    }

    public String getHour() {
        return hour;
    }

    public void setHour(String hour) {
        this.hour = hour;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public Integer getTimeoutSecond() {
        return timeoutSecond;
    }

    public void setTimeoutSecond(Integer timeoutSecond) {
        this.timeoutSecond = timeoutSecond;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        CustomIndexInformationEntity that = (CustomIndexInformationEntity) o;

        if (id != that.id)
            return false;
        if (day != null ? !day.equals(that.day) : that.day != null)
            return false;
        if (hour != null ? !hour.equals(that.hour) : that.hour != null)
            return false;
        if (indexName != null ? !indexName.equals(that.indexName) : that.indexName != null)
            return false;
        if (minute != null ? !minute.equals(that.minute) : that.minute != null)
            return false;
        if (timeoutSecond != null ? !timeoutSecond.equals(that.timeoutSecond) : that.timeoutSecond != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (indexName != null ? indexName.hashCode() : 0);
        result = 31 * result + (minute != null ? minute.hashCode() : 0);
        result = 31 * result + (hour != null ? hour.hashCode() : 0);
        result = 31 * result + (day != null ? day.hashCode() : 0);
        result = 31 * result + (timeoutSecond != null ? timeoutSecond.hashCode() : 0);
        return result;
    }
}
