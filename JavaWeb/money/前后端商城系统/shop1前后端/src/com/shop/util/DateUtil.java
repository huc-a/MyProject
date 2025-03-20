package com.shop.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    public static Date parseYYYYMMDDHHMMSS(String date){
        try {
            DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
            Date date1 = fmt.parse(date);
            return date1;
        } catch (Exception e){
            System.out.println(e);
        }
        return null;
    }

}
