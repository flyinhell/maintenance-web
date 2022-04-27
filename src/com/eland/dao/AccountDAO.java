package com.eland.dao;

import com.eland.pojo.model.AccountEntity;
import com.eland.util.DbOpviewMaintenanceUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.xml.bind.DatatypeConverter;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 * Created by johnnyhuang on 2018/3/8.
 */
public class AccountDAO {
    public static Logger log = LoggerFactory.getLogger(AccountEntity.class);

    /**
     * 取得該使用者之資訊
     *
     * @param user 使用者
     *@param password 密碼
     * @return 使用者相關資訊(email, admin等)
     */
    public AccountEntity getByUserPassWord(String user, String password) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        AccountEntity resultList = null;
        try {
            //MD5加密
            password = md5(password);

            resultList = (AccountEntity) session.createQuery("FROM  AccountEntity WHERE userName = ? AND password = ?")
                                                .setString(0, user)
                                                .setString(1, password)
                                                .uniqueResult();
        } catch (Exception e) {
            log.error("AccountDAO.getByUser 發生錯誤： 使用者帳號=" + user, e);
        } finally {
            session.close();
        }
        return resultList;
    }

    /**
     * 取得該使用者之資訊
     *
     * @param user 使用者
     * @return 使用者相關資訊(email, admin等)
     */
    public AccountEntity getByUser(String user) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        AccountEntity resultList = null;
        try {
            resultList = (AccountEntity) session.createQuery("FROM  AccountEntity WHERE userName = ?")
                                                .setString(0, user)
                                                .uniqueResult();
        } catch (Exception e) {
            log.error("AccountDAO.getByUser 發生錯誤： 使用者帳號=" + user, e);
        } finally {
            session.close();
        }
        return resultList;
    }


    /**
     * 取得 所有使用者
     *
     * @return 使用者相關資訊
     */
    public List<AccountEntity> list(String user) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        List<AccountEntity> resultList = null;
        try {
            resultList = session.createQuery("FROM  AccountEntity WHERE userName != ?")
                                .setString(0,user)
                                .list();
        } catch (Exception e) {
            log.error("AccountDAO.list 發生錯誤： ", e);
        } finally {
            session.close();
        }
        return resultList;
    }

    /**
     * 刪除使用者資訊
     *
     * @param accountEntity 使用者資訊物件
     */
    public void delete(AccountEntity accountEntity) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        try {
            session.delete(accountEntity);
            tx.commit();
        } catch (HibernateException e) {
            log.error("AccountDAO.delete 發生錯誤：", e);
            tx.rollback();
        } finally {
            session.close();
        }
    }

    /**
     * 更新使用者資訊
     *
     * @param accountEntity 使用者資訊物件
     */
    public void editPassword(AccountEntity accountEntity, String password) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        try {
            password = md5(password);
            accountEntity.setPassword(password);
            session.update(accountEntity);
            tx.commit();
        } catch (HibernateException e) {
            log.error("AccountDAO.update 發生錯誤：", e);
            tx.rollback();
        } finally {
            session.close();
        }
    }

    //編輯email
    public void editEmail(AccountEntity accountEntity) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        try {
            session.update(accountEntity);
            tx.commit();
        } catch (HibernateException e) {
            log.error("AccountDAO.update 發生錯誤：", e);
            tx.rollback();
        } finally {
            session.close();
        }
    }

    //更改密碼
    public void updatePassword(AccountEntity accountEntity, String newPassword) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        try {
            newPassword = md5(newPassword);
            accountEntity.setPassword(newPassword);
            session.update(accountEntity);
            tx.commit();
        } catch (HibernateException e) {
            log.error("AccountDAO.updatePassword 發生錯誤：", e);
            tx.rollback();
        }  finally {
            session.close();
        }
    }
    //更改信箱
    public void updateEmail(AccountEntity accountEntity, String email) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();
        try {
            accountEntity.setEmail(email);
            session.update(accountEntity);
            tx.commit();
        } catch (HibernateException e) {
            log.error("AccountDAO.updatePassword 發生錯誤：", e);
            tx.rollback();
        }  finally {
            session.close();
        }
    }
    /**
     * 更新使用者資訊
     *
     * @param accountEntity 使用者資訊物件
     */
    public void insert(AccountEntity accountEntity, String password) {
        Session session = DbOpviewMaintenanceUtil.getSession();
        Transaction tx = session.beginTransaction();

        try {
            //MD5加密
            password = md5(password);
            accountEntity.setPassword(password);
            session.save(accountEntity);
            tx.commit();
        } catch (HibernateException e) {
            log.error("HibernateException!!");
            log.error("AccountDAO.insert 發生錯誤：", e);
            tx.rollback();
        } finally {
            session.close();
        }
    }

    /**
     * 判斷使用者帳號是否存在
     *
     * @param userAccount 使用者帳號
     * @return 帳號是否存在
     */
    public boolean isExistAccount(String userAccount) {
        boolean isEsist = false;
        Session session = DbOpviewMaintenanceUtil.getSession();
        try {
            int result = ((Long) session.createQuery("SELECT COUNT(*) FROM AccountEntity  WHERE userName = ?")
                                        .setString(0, userAccount)
                                        .uniqueResult()).intValue();

            if (result > 0) {
                isEsist = true;
            }
        } catch (Exception e) {
            log.error("AccountDAO.isExistAccount：使用者帳號=" + userAccount, e);
        } finally {
            session.close();
        }
        return isEsist;
    }

    public String md5(String password) {
        try {
            //MD5加密
            password = DatatypeConverter.printHexBinary(
                    MessageDigest.getInstance("MD5").digest(password.getBytes("UTF-8")));
        } catch (Exception e) {
            log.error("MD5加密失敗", e);
        }
        return password;
    }
}
