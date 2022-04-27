package com.eland.backend;

import com.eland.util.FileProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by kueihenglu on 2018/4/3.
 */
@WebServlet("/ExecuteBatchFile")
public class ExecuteBatchFile extends HttpServlet {

    public static Logger log = LoggerFactory.getLogger(ExecuteBatchFile.class);

    private static FileProperties properties = new FileProperties("OpviewMaintenance.properties");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String BatchPath = request.getParameter("BatchPath");
        Runtime rt = Runtime.getRuntime();
        Process ps = null;

        if (BatchPath.equals("startStandardBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("standardDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("startTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("startTDSBatchPath") + " " + properties.getProperty("standardDS"));
        } else if (BatchPath.equals("stopStandardBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("standardDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("stopTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("stopTDSBatchPath") + " " + properties.getProperty("standardDS"));
        } else if (BatchPath.equals("startAdvancedBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("advancedDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("startTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("startTDSBatchPath") + " " + properties.getProperty("advancedDS"));
        } else if (BatchPath.equals("stopAdvancedBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("advancedDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("stopTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("stopTDSBatchPath") + " " + properties.getProperty("advancedDS"));
        } else if (BatchPath.equals("startStaffBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("staffDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("startTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("startTDSBatchPath") + " " + properties.getProperty("staffDS"));
        } else if (BatchPath.equals("stopStaffBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("staffDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("stopTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("stopTDSBatchPath") + " " + properties.getProperty("staffDS"));
        } else if (BatchPath.equals("startEducationBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("educationDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("startTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("startTDSBatchPath") + " " + properties.getProperty("educationDS"));
        } else if (BatchPath.equals("stopEducationBatch")) {
            OpenSSHClient sshClient = new OpenSSHClient(properties.getProperty("educationDS"), 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + properties.getProperty("stopTDSBatchPath"));
//                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("stopTDSBatchPath") + " " + properties.getProperty("educationDS"));
        } else if (BatchPath.equals("startInspectorBatch")) {
                ps = rt.exec("cmd.exe /C start /b " + properties.getProperty("startInspectorPath"));
        }

//            try {
//                ps.waitFor();
//                int i = ps.exitValue();
//                if (i == 0) {
//                    log.info("execute batch succeed");
//                }else{
//                    log.error("execute batch error");
//                }
//            } catch (InterruptedException e) {
//                log.error("Exception: " + e.getMessage());
//            }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
