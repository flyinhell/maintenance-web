package com.eland.backend;

import org.apache.log4j.Logger;

import java.io.File;

/**
 * Created by wycai on 2015/5/22.
 */
public class DeleteFiles {

    private static Logger logger = Logger.getLogger("Log");


    public void delete(File file) {
        if (file.exists()) {
            try {
                if (file.isFile()) {
                    file.delete();
                } else if (file.isDirectory()) {
                    File files[] = file.listFiles();
                    for (int i = 0; i < files.length; i++) {
                        delete(files[i]);
                    }
                }

            } catch (Exception e) {
                logger.error("刪除File 發生錯誤：", e);
            }

        } else {
            logger.info(" - delete fail, file not exist");
        }
    }
}
