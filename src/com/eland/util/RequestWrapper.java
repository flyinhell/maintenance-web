package com.eland.util;

import javax.servlet.http.HttpServletRequest;

/**
 * Http請求(HttpRequest)包裝類別,包含一些請求參數的處理
 * Date: 2012/10/21
 * Time: 下午 4:38
 */
public class RequestWrapper {
    protected HttpServletRequest request;
    protected String defaultString = "";
    protected int defaultInt = 0;
    protected long defaultLong = 0;
    protected String[] defaultStringArray = new String[0];
    protected int[] defaultIntArray = new int[0];
    protected boolean ifTrimStrings = true;

    /**
     * Constructor.
     */
    public RequestWrapper() {

    }

    /**
     * Constructor.
     *
     * @param request HttpRequest which will be wrapped in.
     */
    public RequestWrapper(HttpServletRequest request) {
        this();
        setRequest(request);
    }

    /**
     * 過濾 特殊字元 '<','>','%'
     */
    public static String filterString(String userInput) {

        String filtered = userInput.replaceAll("([<>%]+)", "_");
        return filtered;

    }

    /**
     * Get parameter with name as paramName from HttpRequest.
     * Returned value is a converted String.
     *
     * @param paramName Request parameter name
     * @return If value of paramName is null, defaultString will be
     * returned.
     */
    public String getParameter(String paramName) {
        return getParameter(paramName, defaultString);
    }

    /**
     * Get parameter with name as paramName from HttpRequest.
     * Returned value is a converted String.
     *
     * @param paramName Request parameter name
     * @param def       default value.
     * @return Converted String.
     * If value of paramName is null, def will be returned.
     */
    public String getParameter(String paramName, String def) {
        if (request == null) return def;

        String result = request.getParameter(paramName);
        if (result == null) return def;
        if (ifTrimStrings) result = filterString(trimString(result));

        return result;
    }

    /**
     * Get parameter with multiple values with name as
     * paramName from HttpRequest.
     * Returned value is an array of converted Strings.
     *
     * @param paramName Request parameter name
     * @return If value of paramName is null, defaultStringArray will
     * be returned.
     */
    public String[] getParameterValues(String paramName) {
        return getParameterValues(paramName, defaultStringArray);
    }

    /**
     * Get parameter with multiple values with name as
     * paramName from HttpRequest.
     * Returned value is an array of converted Strings.
     *
     * @param paramName Request parameter name
     * @param def       default value string list
     * @return If value of paramName is null, def will be returned.
     */
    public String[] getParameterValues(String paramName, String[] def) {
        if (request == null) return def;

        String[] result = request.getParameterValues(paramName);
        if (result == null) return def;
        try {
            if (ifTrimStrings) {
                for (int i = 0; i < result.length; i++)
                    result[i] = filterString(trimString(result[i]));
            }
        } catch (Exception e) {

        }
        return result;
    }

    /**
     * Get parameter with name as paramName from HttpRequest.
     * Returned value is converted to be int.
     *
     * @param paramName Request parameter name
     * @return If any Exception occurs while converting to int, 0
     * will be returned. Otherwise, converted int.
     */
    public int getInt(String paramName) {
        return getInt(paramName, defaultInt);
    }

    /**
     * Get parameter with name as paramName from HttpRequest.
     * Returned value is converted to be int.
     *
     * @param paramName Request parameter name
     * @param def       default int value
     * @return If any Exception occurs while converting to int, def
     * will be returned. Otherwise, converted int.
     */
    public int getInt(String paramName, int def) {
        try {
            return Integer.parseInt(getParameter(paramName));
        } catch (Exception e) {
            return def;
        }
    }

    /**
     * Get parameter with multiple values with name as
     * paramName from HttpRequest.
     * Returned value is an array of converted int.
     * All values will be converted to be int. If Exception
     * throwed while converting, defaultInt will be returned.
     *
     * @param paramName Request parameter name
     * @return An Array stores Integers.
     */
    public int[] getParameterInts(String paramName) {
        String[] sa = getParameterValues(paramName);
        int[] result = null;
        if (sa == null) {
            return defaultIntArray;
        }

        result = new int[sa.length];
        for (int i = 0; i < sa.length; i++) {
            try {
                result[i] = Integer.parseInt(sa[i]);
            } catch (Exception e) {
                result[i] = defaultInt;
            }
        }
        return result;
    }

    /**
     * Get parameter with name as paramName from HttpRequest.
     * Returned value is converted to be long.
     *
     * @param paramName Request parameter name
     * @return If any Exception occurs while converting to long, 0
     * will be returned. Otherwise, converted long.
     */
    public long getLong(String paramName) {
        return getLong(paramName, defaultLong);
    }

    /**
     * Get parameter with name as paramName from HttpRequest.
     * Returned value is converted to be long.
     *
     * @param paramName Request parameter name
     * @param def       default long value
     * @return If any Exception occurs while converting to long, def
     * will be returned. Otherwise, converted long.
     */
    public long getLong(String paramName, long def) {
        try {
            return Long.parseLong(getParameter(paramName));
        } catch (Exception e) {
            return def;
        }
    }

    /**
     * If any Exception occurs, "" will be returned.
     *
     * @param s String which will be trim
     * @return String
     */
    protected String trimString(String s) {
        if (s == null) return s;
        return s.trim();
    }


    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

    public String getDefaultString() {
        return defaultString;
    }

    public void setDefaultString(String defString) {
        if (this.ifTrimStrings)
            if (defString != null) defString = defString.trim();

        this.defaultString = defString;
    }

    public long getDefaultLong() {
        return defaultLong;
    }

    public void setDefaultLong(long defaultLong) {
        this.defaultLong = defaultLong;
    }

    public int getDefaultInt() {
        return defaultInt;
    }

    public void setDefaultInt(int defaultInt) {
        this.defaultInt = defaultInt;
    }

    public boolean getIfTrimStrings() {
        return ifTrimStrings;
    }

    public void setIfTrimStrings(boolean ifTrimStrings) {
        this.ifTrimStrings = ifTrimStrings;

        if (this.ifTrimStrings)
            if (defaultString != null) defaultString = defaultString.trim();
    }

    public String[] getDefaultStringArray() {
        return defaultStringArray;
    }

    public void setDefaultStringArray(String[] defaultStringArray) {
        this.defaultStringArray = defaultStringArray;
    }

    public int[] getDefaultIntArray() {
        return defaultIntArray;
    }

    public void setDefaultIntArray(int[] defaultIntArray) {
        this.defaultIntArray = defaultIntArray;
    }
}
