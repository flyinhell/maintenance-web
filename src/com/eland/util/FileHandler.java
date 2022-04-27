package com.eland.util;

import java.io.*;
import java.util.*;

/**
 * 檔案處理
 * <p>
 * Created by danielhsieh on 2014/2/13.
 */
public class FileHandler {
    public final static int MAX_BUF_SIZE = 8 * 1024;

    /**
     * Creates the directory.
     *
     * @param target the target directory
     * @return true if the directory is successfully created; false otherwise
     * @throws java.io.IOException
     */
    public static boolean createDir(String target) throws IOException {
        File targetDir = new File(target);
        if (!targetDir.exists()) {    //目的目錄不存在,才繼續
            if (!targetDir.isDirectory()) {    //建立目的目錄
                boolean created = targetDir.mkdirs();
                if (!created) {
                    return false;

                }
            }
        }
        return true;
    }

    /**
     * copy directory, include files and directories in the source directory
     *
     * @param source source directory
     * @param target target directory
     * @return true if the directory is successfully copy; false otherwise
     * @throws java.io.IOException
     */
    public static boolean copyDir(String source, String target) throws IOException {
        return copyDir(new File(source), new File(target));
    }

    /**
     * copy directory, include files and directories in the source directory
     *
     * @param sourceDir source directory
     * @param targetDir target directory
     * @return true if the directory is successfully copy; false otherwise
     * @throws java.io.IOException
     */
    public static boolean copyDir(File sourceDir, File targetDir) throws IOException {
        if (sourceDir.exists()) {    //來源目錄存在,才繼續
            if (!targetDir.isDirectory()) {    //建立目的目錄
                if (!targetDir.mkdirs()) {
                    return false;
                }
            }
            //如果要把目錄copy到子目錄下則跳出
            if (targetDir.getCanonicalPath().startsWith(sourceDir.getCanonicalPath())) {
                return false;
            }
            String[] flist = sourceDir.list();    //列出所有檔案

            for (int i = 0; i < flist.length; i++) {
                File src = new File(sourceDir, flist[i]);
                File dest = new File(targetDir, flist[i]);

                if (src.isFile()) {    //複製檔案
                    copyFile(src, dest);
                } else if (src.isDirectory()) {    //複製目錄
                    if (!flist[i].equals(".") && !flist[i].equals("..")) {
                        if (!copyDir(src, dest))
                            return false;
                    }
                }
            }
        }
        return true;
    }

    /**
     * copy file
     *
     * @param source source file pathname
     * @param target target file pathname
     * @throws java.io.IOException
     */
    public static void copyFile(String source, String target) throws IOException {
        copyFile(new File(source), new File(target));
    }

    public static void copyFile(File source, File target) throws IOException {
        InputStream fis = null;
        OutputStream fos = null;
        byte[] buf = new byte[MAX_BUF_SIZE];

        try {
            fis = new BufferedInputStream(new FileInputStream(source));
            fos = new BufferedOutputStream(new FileOutputStream(target));
            int result;

            while ((result = fis.read(buf)) != -1) {
                fos.write(buf, 0, result);
            }
        } finally {
            try {
                if (fis != null)
                    fis.close();
                if (fos != null)
                    fos.close();
            } catch (IOException e) {
            }
        }
    }

    /**
     * delete directory, include all files and directories in the target directory
     *
     * @param target the directory name to delete
     * @return true if the directory is successfully deleted; false otherwise
     */
    public static boolean deleteDir(String target) {
        return deleteDir(new File(target));
    }

    /**
     * delete directory, include all files and directories in the target directory
     *
     * @param targetDir the directory name to delete
     * @return true if the directory is successfully deleted; false otherwise
     */
    public static boolean deleteDir(File targetDir) {
        //要刪除的目錄
        if (targetDir.exists() && !targetDir.delete()) {                // 表示targetDir為目錄且不為空
            Vector dirlist = new Vector();        // 用來儲存所有的目錄列表
            Vector dirtemp = new Vector();        // 用來暫存目錄列表
            String[] filelist = targetDir.list();    // 列出目錄下所有檔案

            if (filelist != null) {            //避免目錄下為空時有NullPointerException
                for (int i = 0; i < filelist.length; i++) {    // 一個一個檢查
                    File test = new File(targetDir, filelist[i]);
                    if (test.isDirectory()) {        // 如果是子目錄,則加到dirlist
                        dirlist.addElement(test);
                        dirtemp.addElement(test);    // 加到待處理中
                    } else if (test.isFile()) {        // 如果是檔案就刪除
                        test.delete();
                    }
                }
            }

            while (!dirtemp.isEmpty()) {        // 還有目錄要處理
                File subDir = (File) dirtemp.elementAt(0);    //拿出第一個來處理
                dirtemp.removeElementAt(0);
                String filepath = subDir.toString();
                filelist = subDir.list();
                if (filelist != null) {
                    for (int i = 0; i < filelist.length; i++) {
                        File test = new File(filepath + File.separatorChar + filelist[i]);
                        if (test.isDirectory()) {        // 如果是子目錄,則加到dirlist
                            dirlist.addElement(test);
                            dirtemp.addElement(test);    // 加到待處理中
                        } else if (test.isFile()) {        // 如果是檔案就刪除
                            test.delete();
                        }
                    }
                }
            }

            // 目錄下檔案都已清空,刪除所有目錄
            int length = dirlist.size();
            for (int i = length - 1; i >= 0; i--) {
                ((File) dirlist.elementAt(i)).delete();
            }

            targetDir.delete();
        }
        return (!targetDir.exists());
    }

    /**
     * move directory, include files and directories in the source directory
     *
     * @param source source directory pathname
     * @param target target directory pathname
     * @return true if the directory is successfully moved; false otherwise
     * @throws java.io.IOException
     */
    public static boolean moveDir(String source, String target) throws IOException {
        return moveDir(new File(source), new File(target));
    }

    /**
     * move directory, include files and directories in the source directory
     *
     * @param source source directory pathname
     * @param target target directory pathname
     * @return true if the directory is successfully moved; false otherwise
     * @throws java.io.IOException
     */
    public static boolean moveDir(File source, File target) throws IOException {
        return copyDir(source, target) ? deleteDir(source) : false;
    }

    /**
     * list files of a directory
     *
     * @param target target directory pathname
     * @return list of filenames
     */
    public static File[] listFile(File target) {
        Vector result = new Vector();

        if (target.exists()) {
            String[] flist = target.list();    //列出所有檔案

            for (String aFlist : flist) {
                File test = new File(target, aFlist);
                if (test.isFile()) {
                    result.add(test);
                }
            }
        }
        return (File[]) result.toArray(new File[0]);
    }

    /**
     * list files of a directory
     *
     * @param targetDir target directory pathname
     * @return list of filenames
     */
    public static String[] listFile(String targetDir) {
        Vector result = new Vector();
        File target = new File(targetDir);
        if (target.exists()) {
            String[] flist = target.list();    //列出所有檔案

            for (String aFlist : flist) {
                File test = new File(targetDir + File.separator + aFlist);
                if (test.isFile()) {
                    result.add(aFlist);
                }
            }
        }
        return (String[]) result.toArray(new String[0]);
    }
}
