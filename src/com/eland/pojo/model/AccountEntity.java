package com.eland.pojo.model;

/**
 * Created by johnnyhuang on 2018/3/8.
 */
public class AccountEntity {
    private int id;
    private String userName;
    private String password;
    private String email;
    private Integer permissions;
    private String emailSwitch;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getPermissions() {
        return permissions;
    }

    public void setPermissions(Integer permissions) {
        this.permissions = permissions;
    }

    public String getEmailSwitch() {
        return emailSwitch;
    }

    public void setEmailSwitch(String emailSwitch) {
        this.emailSwitch = emailSwitch;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        AccountEntity that = (AccountEntity) o;

        if (id != that.id)
            return false;
        if (email != null ? !email.equals(that.email) : that.email != null)
            return false;
        if (password != null ? !password.equals(that.password) : that.password != null)
            return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null)
            return false;
        if (permissions != null ? !permissions.equals(that.permissions) : that.permissions != null)
            return false;
        if (emailSwitch != null ? !emailSwitch.equals(that.emailSwitch) : that.emailSwitch != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        return result;
    }
}
