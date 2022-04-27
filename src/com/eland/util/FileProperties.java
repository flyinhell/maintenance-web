package com.eland.util;

import org.slf4j.Logger;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Properties;

/**
 * Properties設定檔公用程式
 * <p>
 * Created by danielhsieh on 2014/6/11.
 */
public class FileProperties extends Properties {
    private Properties properties = new Properties();
    public static Logger logger = org.slf4j.LoggerFactory.getLogger(FileProperties.class);

    /**
     * 建構子
     * 將相對路徑轉成絕對路徑後，再將路徑使用UTF-8編碼，
     *
     * @param propertiesPath 欲讀取設定檔的路徑
     */
    public FileProperties(String propertiesPath) {
        String path = getAbsolutePath(propertiesPath);
        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(path);
            properties.load(fileInputStream);
        } catch (FileNotFoundException e) {
            logger.error("找不到" + path + "檔案", e);
        } catch (IOException e) {
            logger.error("讀取設定檔發生異常", e);
        } finally {
            try {
                if (fileInputStream != null) {
                    fileInputStream.close();
                }
            } catch (Exception e) {
                logger.error("關閉設定檔發生錯誤：", e);
            }
        }
    }

    /**
     * 取得設定檔絕對路徑
     *
     * @param relativePath 相對路徑
     * @return 絕對路徑字串
     */
    public static String getAbsolutePath(String relativePath) {
        String absolutePath = "";
        URL resource = Thread.currentThread().getContextClassLoader().getResource(relativePath);
        if (resource != null) {
            try {
                absolutePath = URLDecoder.decode(resource.getPath(), "utf-8");
            } catch (UnsupportedEncodingException e) {
                logger.error("不支援UTF-8編碼檔案", e);
            }
        }
        return absolutePath;
    }

    /**
     * 取得設定檔中的參數值並去掉頭尾空白
     *
     * @param key 設定的參數名稱
     * @return 設定的值
     */
    public String getProperty(String key) {
        return properties.getProperty(key).trim();
    }
}
