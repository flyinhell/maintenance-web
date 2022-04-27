package com.eland.backend;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

import org.apache.log4j.Logger;

/**
 * Created by wycai on 2015/5/22.
 * <p>
 * 複製檔案 by fileChannel
 */
public class CopyFiles {

    private static Logger log = Logger.getLogger("Log");

    public boolean copyFile(String srFile, String dtFile) {
        boolean check;
        boolean makeDir;

        int dir = dtFile.lastIndexOf("\\");
        String fileDir = dtFile.substring(0, dir);
        try {
            File file = new File(fileDir);

            makeDir = file.mkdirs();

        } catch (Exception e) {
            log.error("MakeDri Fail", e);
        }

        try {
            FileChannel srcChannel = new FileInputStream(srFile).getChannel();
            FileChannel dstChannel = new FileOutputStream(dtFile).getChannel();
            ByteBuffer byteBuffer = ByteBuffer.allocate(102400);
            while (srcChannel.read(byteBuffer) != -1) {
                byteBuffer.flip();
                dstChannel.write(byteBuffer);
                byteBuffer.clear();//prepare for reading;清空缓冲
            }
            srcChannel.close();
            dstChannel.close();
            check = true;
        } catch (IOException e) {
            e.printStackTrace();
            log.error("Copy Fail!!", e);
            check = false;
        }
        return check;
    }

    //複製資料夾
    public boolean copyDirectory(File source, File target, String pathSymbol) {
        boolean check = false;
        try {
            File[] file = source.listFiles();
            for (int i = 0; i < file.length; i++) {
                if (file[i].isFile()) {
                    File sourceDemo = new File(source.getAbsolutePath() + pathSymbol + file[i].getName());
                    File destDemo = new File(target.getAbsolutePath() + pathSymbol + file[i].getName());
                    check = copyFile(sourceDemo.toString(), destDemo.toString());
                } else if (file[i].isDirectory()) {
                    File sourceDemo = new File(source.getAbsolutePath() + pathSymbol + file[i].getName());
                    File destDemo = new File(target.getAbsolutePath() + pathSymbol + file[i].getName());
                    destDemo.mkdir();
                    check = copyDirectory(sourceDemo, destDemo, pathSymbol);
                }
                if (!check) {
                    log.info(" - copy fail!!!");
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error(e.getMessage());
        }
        return check;
    }
}
