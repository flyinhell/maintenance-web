package com.eland.backend;

import com.eland.util.FileHandler;

import java.io.*;
import javax.servlet.http.HttpServletRequest;

import com.eland.util.FileProperties;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.Buffer;
import java.util.*;

/**
 * Created by johnnyhuang on 2015/5/8.
 */
public class UploadFiles {
    public static Logger logger = LoggerFactory.getLogger(UploadFiles.class);
    private static FileProperties properties = new FileProperties("OpviewMaintenance.properties");

    private final int BufferSize = 4096;
    private final int FileSizeMax = Integer.parseInt(properties.getProperty("FileSizeMax")); //最大檔案大小
    private File tempFile = null;
    private String uploadDir = null;
    // 用來存parameter
    private Map textFieldMap = null;
    private Map fileMap = null;

    // 初始化時把request所有的值給取出,並存入requestMap
    public UploadFiles(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException {
        // 初始化內容
        textFieldMap = new HashMap();
        fileMap = new HashMap();

        try {
            //設定request編碼
            request.setCharacterEncoding("utf-8");
            // 建立一個以disk-base的檔案物件
            DiskFileItemFactory diskFileItemfactory = new DiskFileItemFactory();

            // 傳送所用的buffer空間
            diskFileItemfactory.setSizeThreshold(BufferSize);

            // The directory in which temporary files will be located.
            diskFileItemfactory.setRepository(tempFile);

            // 建立一個檔案上傳的物件
            ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemfactory);

            // 最大檔案大小
            //servletFileUpload.setSizeMax(FileSizeMax);

            // 把資料從request取出，會產生 FileUploadException
            List itemsList = servletFileUpload.parseRequest(request); // Parse the request
            Iterator iter = itemsList.iterator();

            while (iter.hasNext()) {// 先把所有參數取得而不先write to file
                // 每一個Fileitem代表一個form上傳的物件內容ex input type="text"
                FileItem fileItem = (FileItem) iter.next();
                fileItem.getString("utf-8");
                // 一般文字欄位
                if (fileItem.isFormField()) {
                    textFieldMap.put(fileItem.getFieldName(), fileItem.getString("UTF-8"));
                    logger.info("表單欄位之值：" + fileItem.getName());

                } else {// 上傳檔案欄位
                    //if (fileItem.getSize() > 0) {
                    fileMap.put(fileItem.getFieldName(), fileItem);
                    logger.info("上傳的檔案名稱：" + fileItem.getName());
                }
            }
        } catch (Exception e) {
            logger.error("初始化上傳檔案時發生異常：", e);
        }
    }

    /**
     * 設定檔案上傳的路徑
     *
     * @param uploadDir 檔案上傳的路徑
     */
    public void setUploadDir(String uploadDir) throws IOException {
        FileHandler fileHandler = new FileHandler();
        try {
            if (!fileHandler.createDir(uploadDir)) {
                logger.error("指定上傳路徑不存在，在建立相關路徑時發生失敗");
            }
            this.uploadDir = uploadDir;
        } catch (Exception e) {
            logger.error("設定上傳路徑時發生異常：", e);
        }
    }

    /**
     * 取得某一欄位的值,為一般欄位
     *
     * @param FieldName 表單欄位名稱
     * @return 表單欄位值
     */
    public String getTextParameter(String FieldName) {
        String fieldValue = null;
        try {
            if (textFieldMap.containsKey(FieldName)) {
                fieldValue = String.valueOf(textFieldMap.get(FieldName));
            }
        } catch (Exception e) {
            logger.error("取一般欄位時發生異常：", e);
        }
        return fieldValue;
    }

    /**
     * 取得某一上傳欄位的FileItem
     *
     * @param FieldName 表單欄位名稱
     * @return FileItem
     */
    public FileItem getUploadParameter(String FieldName) {
        FileItem fileItem = null;
        try {
            if (fileMap.containsKey(FieldName)) {
                fileItem = (FileItem) fileMap.get(FieldName);
            }
        } catch (Exception e) {
            logger.error("取一般欄位時發生異常：", e);
        }
        return fileItem;
    }

    /**
     * 取得所有上傳檔案的欄位
     *
     * @return 上傳檔案的表單欄位Map
     */
    public HashMap getAllUploadParameter() {
        HashMap parameterMap = new HashMap();
        try {
            parameterMap.putAll(fileMap);
        } catch (Exception e) {
            logger.error("取上傳檔案欄位時發生異常：", e);
        }
        return parameterMap;
    }

    /**
     * 取得所有一般文字欄位
     *
     * @return 一般文字的表單欄位Map
     */
    public HashMap getAllTextParameter() {
        HashMap<String, String> parameterMap = new HashMap<String, String>();
        try {
            parameterMap.putAll(textFieldMap);
        } catch (Exception e) {
            logger.error("取所有一般欄位時發生異常：", e);
        }
        return parameterMap;
    }

    /**
     * 檢查上傳資料是否錯誤
     *
     * @return 錯誤訊息
     */
    public String checkUpload() throws UnsupportedEncodingException {
        String errorMessage = "";
        try {
            Set<String> fileItemSet = fileMap.keySet();
            for (String uploadFieldName : fileItemSet) {
                FileItem fileItem = (FileItem) fileMap.get(uploadFieldName);
                fileItem.getString("utf-8");
                if (fileItem.getSize() > FileSizeMax) {
                    errorMessage = "檔案大小超過限制，請重新上傳";
                    logger.error("檔案大小超過限制");
                }
            }
        } catch (Exception e) {
            logger.error("檢查檔案時發生異常：", e);
        }
        return errorMessage;
    }

    /**
     * 開始上傳
     *
     * @param fileItem 上傳表單欄位資訊
     * @return 錯誤訊息
     */
    public String doUpload(FileItem fileItem) throws UnsupportedEncodingException {
        String errorMessage = "";
        fileItem.getString("utf-8");
        long sizeInBytes = fileItem.getSize();
        // 碓認上傳資料是否有誤
        if (sizeInBytes > FileSizeMax) {
            errorMessage = "檔案大小超過限制，請重新上傳";
            logger.error("檔案大小超過限制");
        } else {
            File uploadedFile = new File(uploadDir + fileItem.getName());
            // 會產生 Exception
            try {
                fileItem.write(uploadedFile);
            } catch (Exception e) {
                errorMessage = "上傳失敗";
                logger.error("上傳檔案發生異常", e);
            }
        }
        return errorMessage;
    }

    /**
     * 是否存在此上傳欄位資料
     *
     * @param fileName 表單欄位名稱
     * @return true or false
     */
    public boolean isExtUpload(String fileName) {
        return fileMap.containsKey(fileName);
    }
}
