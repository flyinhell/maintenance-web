package com.eland.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * Http回應(HttpResponse)包裝類別,包含一些請求參數的處理
 * Created by sphsu on 2014/2/25.
 */
public class ResponseWrapper {
    protected static SimpleDateFormat sdfYMD = new SimpleDateFormat("_yyyy-MM-dd");
    protected HttpServletResponse response;
    protected String attachmentName;
    protected String attachmentExtension;
    protected String contentType;
    protected String characterEncoding = "utf-8";
    protected byte[] buffer = new byte[1024 * 100]; //100K
    private PrintWriter printWriter;

    /**
     * constructor
     *
     * @param response response
     */
    public ResponseWrapper(HttpServletResponse response) {
        setResponse(response);
        setCharacterEncoding(this.characterEncoding);
    }

    /**
     * setting response
     *
     * @param response response
     */
    public void setResponse(HttpServletResponse response) {
        this.response = response;
    }

    /**
     * no cache header
     */
    public void setHeader() {
        this.response.setHeader("Expires", "0");
        this.response.setHeader("Pragma", "no-cache");
        this.response.setHeader("Cache-Control", "must-revalidate");
    }


    /**
     * setting attachment file in header
     *
     * @throws Exception
     */
    private void setAttachment() throws Exception {
        String attachmentName = trimString(this.attachmentName);
        String extension = trimString(this.attachmentExtension);
        if (attachmentName != null && !attachmentName.equals("") && extension != null && !extension.equals("")) {
            String currentDate = String.valueOf(sdfYMD.format(new Date()));
            attachmentName = URLEncoder.encode(attachmentName, this.characterEncoding) + currentDate + "." + extension;
            this.response.setHeader("Content-Disposition", "attachment;filename=" + attachmentName);
        }
    }

    /**
     * setting response encoding
     *
     * @param characterEncoding encoding
     */
    public void setCharacterEncoding(String characterEncoding) {
        this.characterEncoding = trimString(characterEncoding);
        if (this.characterEncoding != null && !this.characterEncoding.equals("")) {
            this.response.setCharacterEncoding(this.characterEncoding);
        }
    }

    /**
     * get response encoding
     *
     * @return
     */
    public String getCharacterEncoding() {
        return characterEncoding;
    }

    /**
     * get response writer
     *
     * @throws IOException
     */
    public void writerContent(String content) throws IOException {
        setPrintWriter(this.response.getWriter());
        getPrintWriter().write(content);
    }

    /**
     * close response writer
     *
     * @throws IOException
     */
    public void writerClose() throws IOException {
        getPrintWriter().flush();
        getPrintWriter().close();
    }

    /**
     * add cookie in response
     *
     * @param cookie cookie
     */
    public void addCookie(Cookie cookie) {
        this.response.addCookie(cookie);
    }

    /**
     * setting json response header
     *
     * @throws Exception
     */
    public void setJSONHeader(String content) throws Exception {
        writerContent(content);
        writerClose();
        setHeader(ContentType.JSON, null);
    }

    /**
     * setting excel file response header
     *
     * @param attachmentName    attachment name
     * @param writeOutputStream will be written OutputStream object
     * @param <T>everyone       extends ByteArrayOutputStream object
     * @throws Exception
     */
    public <T extends ByteArrayOutputStream> void setExcel2003Header(String attachmentName, T writeOutputStream) throws
            Exception {
        setHeader(ContentType.EXCEL_2003, attachmentName);
        writeOutputStream(writeOutputStream);
    }

    /**
     * setting excel file response header
     *
     * @param attachmentName    attachment name
     * @param writeOutputStream will be written OutputStream object
     * @param <T>everyone       extends ByteArrayOutputStream object
     * @throws Exception
     */
    public <T extends ByteArrayOutputStream> void setExcel2007Header(String attachmentName, T writeOutputStream) throws
            Exception {
        setHeader(ContentType.EXCEL_2007, attachmentName);
        writeOutputStream(writeOutputStream);
    }

    /**
     * setting pdf file response header
     *
     * @param attachmentName attachment name
     * @param content        will be written content
     * @throws Exception
     */
    public void setPDFHeader(String attachmentName, String content) throws Exception {
        setHeader(ContentType.PDF, attachmentName);
        writerContent(content);
        writerClose();
    }

    /**
     * setting xml file response header
     *
     * @param attachmentName attachment name
     * @param content        will be written content
     * @throws Exception
     */
    public void setXMLHeader(String attachmentName, String content) throws Exception {
        setHeader(ContentType.XML, attachmentName);
        writerContent(content);
        writerClose();
    }

    /**
     * setting html file response header (download)
     *
     * @param attachmentName attachment name
     * @param content        will be written content
     * @throws Exception
     */
    public void setHTMLDownloadHeader(String attachmentName, String content) throws Exception {
        setHeader(ContentType.HTML, attachmentName);
        writerContent(content);
        writerClose();
    }

    /**
     * setting html file response header (on page)
     *
     * @param attachmentName attachment name
     * @param content        will be written content
     * @throws Exception
     */
    public void setHTMLHeader(String attachmentName, String content) throws Exception {
        writerContent(content);
        writerClose();
        setHeader(ContentType.HTML, attachmentName);
    }

    /**
     * setting txt file response header
     *
     * @param attachmentName attachment name
     * @param content        will be written content
     * @throws Exception
     */
    public void setTXTHeader(String attachmentName, String content) throws Exception {
        setHeader(ContentType.TXT, attachmentName);
        writerContent(content);
        writerClose();
    }


    /**
     * content type
     */
    public enum ContentType {
        JSON("application/json", ""),
        EXCEL_2003("application/ms-excel", "xls"),
        EXCEL_2007("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "xlsx"),
        PDF("application/pdf", "pdf"),
        XML("application/xml", "xml"),
        TXT("text/plain", "txt"),
        HTML("text/html", "html");

        private String contentType;
        private String attachmentExtension;

        private ContentType(String contentType, String attachmentExtension) {
            this.contentType = contentType;
            this.attachmentExtension = attachmentExtension;
        }

        public String getContentTypeName() {
            return contentType;
        }

        public String getAttachmentExtension() {
            return attachmentExtension;
        }
    }

    /**
     * setting response header
     *
     * @param contentType response content type
     * @throws Exception setting header exception
     */
    private void setHeader(ContentType contentType, String attachmentName) throws Exception {
        setContentType(contentType.getContentTypeName());
        setAttachmentName(attachmentName);
        setAttachmentExtension(contentType.getAttachmentExtension());
        setAttachment();
        setHeader();
    }

    /**
     * @param writeOutputStream will be written OutputStream object
     * @param <T>everyone       extends ByteArrayOutputStream object
     * @throws Exception
     */
    private <T extends ByteArrayOutputStream> void writeOutputStream(T writeOutputStream) throws Exception {
        OutputStream outputStream = this.response.getOutputStream();
        if (outputStream != null) {
            byte[] dataByte = writeOutputStream.toByteArray();
            writeOutputStream.close();
            int offset = 0;
            int length = buffer.length;
            int dataLength = dataByte.length;
            while (offset < dataLength) {
                if ((offset + length) > dataLength) {
                    if (length > dataLength) {
                        length = dataLength;
                    } else {
                        length = dataLength - offset;
                    }
                }
                outputStream.write(dataByte, offset, length);
                outputStream.flush();
                offset = offset + length;
            }
            outputStream.close();
        }
    }

    /**
     * String to trim
     *
     * @param str String
     * @return String to trim
     */
    private String trimString(String str) {
        if (str == null) {
            return str;
        }
        return str.trim();
    }

    /**
     * get attachment file name
     *
     * @return attachment file name
     */
    public String getAttachmentName() {
        return attachmentName;
    }

    /**
     * setting attachment file name
     *
     * @param attachmentName attachment file name
     */
    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    /**
     * get attachment file extension
     *
     * @return attachment file extension
     */
    public String getAttachmentExtension() {
        return attachmentExtension;
    }

    /**
     * setting attachment file extension
     *
     * @param attachmentExtension attachment file extension
     */
    public void setAttachmentExtension(String attachmentExtension) {
        this.attachmentExtension = attachmentExtension;
    }

    /**
     * get response content type
     *
     * @return content type
     */
    public String getContentType() {
        return contentType;
    }

    /**
     * setting response content type
     *
     * @param contentType content type
     */
    public void setContentType(String contentType) {
        this.contentType = trimString(contentType);
        if (this.contentType != null && !this.contentType.equals("")) {
            this.response.setContentType(contentType);
        }
    }

    /**
     * setting download file cookie with fail
     *
     * @param fileDownload download file cookie
     */
    public static void setFileDownloadFail(Cookie fileDownload) {
        fileDownload.setValue("false");
    }

    /**
     * setting download file cookie with success
     *
     * @param fileDownload download file cookie
     */
    public static void setFileDownloadSuccess(Cookie fileDownload) {
        fileDownload.setValue("true");
    }

    /**
     * get download file cookie
     *
     * @return download file cookie
     */
    public static Cookie fileDownload = new Cookie("fileDownload", "false");

    public static Cookie getFileDownloadCookie() {
        fileDownload.setPath("/");
        fileDownload.setMaxAge(3600);
        return fileDownload;
    }

    /**
     * get PrintWriter object
     *
     * @return PrintWriter
     */
    public PrintWriter getPrintWriter() {
        return printWriter;
    }

    /**
     * setting PrintWriter object
     *
     * @param printWriter PrintWriter object
     */
    public void setPrintWriter(PrintWriter printWriter) {
        this.printWriter = printWriter;
    }
}
