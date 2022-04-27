package com.eland.util;

import java.util.Calendar;

/**
 * Created by wycai on 2015/5/26.
 */
public class OpviewMaintenanceUtil {

    /**
     * 取得cookie存活時間 到期時間為每日的23:59:59.99
     *
     * @return live time
     */
    public static int getCookieLiveTime() {
        Calendar calendar = Calendar.getInstance();
        long current = calendar.getTimeInMillis();
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        long endTime = calendar.getTimeInMillis();
        return (int) ((endTime - current) * 1.0 / 1000);
    }

    /**
     * 數字不足部份補零回傳
     *
     * @param str     字串
     * @param lenSize 字串數字最大長度,不足的部份補零
     * @return 回傳補零後字串數字
     */
    public static String MakesUpZero(String str, int lenSize) {
        String zero = "0000000000";
        String returnValue = zero;

        returnValue = zero + str;

        return returnValue.substring(returnValue.length() - lenSize);

    }
}
