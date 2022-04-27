package com.eland.cloner;

import com.eland.dao.IndexTaskInformationDAO;
import com.eland.dao.MachineTypeMappingDAO;
import com.eland.dao.RollbackTaskDAO;
import com.eland.util.FileProperties;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

public class CallTaskQueueTools {
    private static Logger log = Logger.getLogger("Log");
    private static FileProperties properties = new FileProperties("OpviewMaintenance.properties");
    IndexTaskInformationDAO informationDAO = new IndexTaskInformationDAO();
    RollbackTaskDAO rollbackTaskDAO = new RollbackTaskDAO();


    public void callTaskQueueRestartTools(String machineName) {
        Map<String, String> machineIpMap = new HashMap();
        for(Map.Entry indexerIp : MachineTypeMappingDAO.indexer.entrySet()){
            machineIpMap.put(indexerIp.getKey().toString(), indexerIp.getValue().toString());
        }


        try {
            if (machineName.contains("indexer")) {

                callIndexerStartupTools(machineIpMap.get(machineName).toString());
                Thread.sleep(TimeUnit.SECONDS.toMillis(10));
                informationDAO.updateByIndexer(machineName);
                rollbackTaskDAO.updateRollbackByIndexer(machineName);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    public void callIndexerStartupTools(String ip) {

        String cmd = "sh /opt/opviewapi/api/javaprogram/Opview_Index_Task_Queue/restart.sh";
        try {
            JSch jsch = new JSch();
            String host = ip;
            String user = "rd5";
            int port = 22;
            Session session = jsch.getSession(user, host, port);
            session.setPassword("eland1234");
            session.setConfig("StrictHostKeyChecking", "no");
            session.connect(30000);   // making a connection with timeout.

            Channel channel = session.openChannel("exec");
            ((ChannelExec) channel).setCommand(cmd);
            channel.connect();
            BufferedReader br = new BufferedReader(new InputStreamReader(channel.getInputStream()));
            String line = null;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
            channel.disconnect();
            session.disconnect();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }

    }

    public void callTaskQueueStopTools(String machineName) {
        Map<String, String> machineIpMap = new HashMap();
        for(Map.Entry indexerIp : MachineTypeMappingDAO.indexer.entrySet()){
            machineIpMap.put(indexerIp.getKey().toString(), indexerIp.getValue().toString());
        }

        try {
            if (machineName.contains("indexer")) {
                callIndexerStopTools(machineIpMap.get(machineName).toString());
                Thread.sleep(TimeUnit.SECONDS.toMillis(10));
//                informationDAO.updateByIndexer(machineName);
//                rollbackTaskDAO.updateRollbackByIndexer(machineName);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    public void callIndexerStopTools(String ip) {

        String cmd = "sh /opt/opviewapi/api/javaprogram/Opview_Index_Task_Queue/stop.sh";
        try {
            JSch jsch = new JSch();
            String host = ip;
            String user = "rd5";
            int port = 22;
            Session session = jsch.getSession(user, host, port);
            session.setPassword("eland1234");
            session.setConfig("StrictHostKeyChecking", "no");
            session.connect(30000);   // making a connection with timeout.

            Channel channel = session.openChannel("exec");
            ((ChannelExec) channel).setCommand(cmd);
            channel.connect();
            BufferedReader br = new BufferedReader(new InputStreamReader(channel.getInputStream()));
            String line = null;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
            channel.disconnect();
            session.disconnect();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }

    }

}
