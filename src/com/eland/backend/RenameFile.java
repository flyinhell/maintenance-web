package com.eland.backend;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

/**
 * Created by wycai on 2015/6/14.
 */
public class RenameFile {

    public static Logger logger = LoggerFactory.getLogger(RenameFile.class);

    public boolean RenameFile(String srFile, String dtFile) {
        boolean check = false;
        System.out.println(srFile);
        System.out.println(dtFile);


        File oldfile = new File(srFile);
        File newfile = new File(dtFile);

        if (oldfile.renameTo(newfile)) {
            System.out.println("Rename successful");
            logger.info("Rename successful");
            check = true;
        } else {
            System.out.println("Rename failed");
            logger.info("Rename failed");
        }

        return check;
    }
}
