package com.eland.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.MessageDigest;

/**
 * 將傳入的字串編碼
 * User: sphsu
 * Date: 2013/4/25
 */
public class Encode {
    public static Logger log = LoggerFactory.getLogger(Encode.class);

    /**
     * @param str        傳入的字串
     * @param encodeType 編碼類型(md5、md2.....
     * @return 已編碼完成字串
     */
    public static String encode(String str, String encodeType) {
        String result = "";
        try {
            //設定要用哪種編碼
            MessageDigest md = MessageDigest.getInstance(encodeType);
            md.update(str.getBytes());
            StringBuffer sb = new StringBuffer();
            byte byteData[] = md.digest();

            //轉成一組固定長度為128 位元（32 個十六進制數字）的結果
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xFF) + 0x100, 16).substring(1));
            }
            result = sb.toString().toUpperCase();
        } catch (Exception e) {
            log.error("Encode.encode發生錯誤：編碼字串=" + str + " 編碼類型=" + encodeType, e);
        }
        return result;
    }
}
