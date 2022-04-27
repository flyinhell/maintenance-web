package com.eland.backend;

import org.apache.log4j.Logger;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class GetMonthBetween {

    private static Logger log = Logger.getLogger("Log");

    public List<String> getMonthBetween(String timeRange) {
        ArrayList<String> result = new ArrayList<String>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");//格式化为年月
        Calendar min = Calendar.getInstance();
        Calendar max = Calendar.getInstance();
        Calendar curr = min;
        String minDate = "";
        String maxDate = "";

        try {
            if (timeRange.contains("~")) {
                String[] sp = timeRange.split("~");
                minDate = sp[0];
                maxDate = sp[1];
                int minDateInt = Integer.valueOf(minDate).intValue();
                int maxDateInt = Integer.valueOf(maxDate).intValue();
                if ((minDateInt - maxDateInt) > 0) {
                    minDate = sp[1];
                    maxDate = sp[0];
                }
                min.setTime(sdf.parse(minDate));
                min.set(min.get(Calendar.YEAR), min.get(Calendar.MONTH), 1);

                max.setTime(sdf.parse(maxDate));
                max.set(max.get(Calendar.YEAR), max.get(Calendar.MONTH), 2);

                while (curr.before(max)) {
                    result.add(sdf.format(curr.getTime()));
                    curr.add(Calendar.MONTH, 1);
                }

            } else {
                minDate = timeRange;
                maxDate = timeRange;
                min.setTime(sdf.parse(minDate));
                min.set(min.get(Calendar.YEAR), min.get(Calendar.MONTH), 1);

                max.setTime(sdf.parse(maxDate));
                max.set(max.get(Calendar.YEAR), max.get(Calendar.MONTH), 2);

                while (curr.before(max)) {
                    result.add(sdf.format(curr.getTime()));
                    curr.add(Calendar.MONTH, 1);
                }

            }
        } catch (ParseException e) {
            e.printStackTrace();
            log.error("getMonthBetween Fail!!", e);
        }
        return result;

    }


}