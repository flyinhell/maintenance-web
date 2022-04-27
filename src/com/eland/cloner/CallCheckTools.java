package com.eland.cloner;

import com.eland.backend.OpenSSHClient;
import com.eland.dao.MachineTypeMappingDAO;
import com.eland.util.FileProperties;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

/**
 * Created by ccyang on 2018/3/21.
 */
public class CallCheckTools {
    private static Logger log = Logger.getLogger("Log");
    private static FileProperties properties = new FileProperties("OpviewMaintenance.properties");

    public void callCheckTools(String machineName) {

        Map<String, String> machineIpMap = new HashMap();
        for (Map.Entry indexerIp : MachineTypeMappingDAO.indexer.entrySet()) {
            machineIpMap.put(indexerIp.getKey().toString(), indexerIp.getValue().toString());
        }
        for (Map.Entry standardIp : MachineTypeMappingDAO.standard.entrySet()) {
            machineIpMap.put(standardIp.getKey().toString(), standardIp.getValue().toString());
        }


        if (machineName.equals("all")) {
            for (Map.Entry entry : machineIpMap.entrySet()) {
                if (entry.getKey().toString().contains("indexer")) {
                    callIndexerCheckTools(entry.getValue().toString());
                } else if (entry.getKey().toString().contains("searcher")) {
                    callSearcherCheckTools(entry.getValue().toString());
                }
            }
        } else if (machineName.equals("allIndexer")) {
            for (Map.Entry entry : machineIpMap.entrySet()) {
                if (entry.getKey().toString().contains("indexer")) {
                    callIndexerCheckTools(entry.getValue().toString());
                }
            }
        } else if (machineName.equals("allSearcher")) {
            for (Map.Entry entry : machineIpMap.entrySet()) {
                if (entry.getKey().toString().contains("searcher")) {
                    callSearcherCheckTools(entry.getValue().toString());
                }
            }
        } else {
            if (machineName.contains("indexer")) {
                callIndexerCheckTools(machineIpMap.get(machineName).toString());
            } else if (machineName.contains("searcher")) {
                callSearcherCheckTools(machineIpMap.get(machineName).toString());
            }

        }

    }


    public void callIndexerCheckTools(String ip) {

        String cmd = "sh /opt/opviewapi/api/javaprogram/Cloner_Tools/Cloner_check.sh";

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
                log.info(line);
                //System.out.printf("\t[Resp] %s\n", line);
            }
            channel.disconnect();
            session.disconnect();
        } catch (Exception e) {
            log.info(e.getMessage());
        }

    }

    public void callSearcherCheckTools(String ip) {

        try {
            String clonerCheckBatchPath = properties.getProperty("checkClonerBatchPath");
            OpenSSHClient sshClient = new OpenSSHClient(ip, 22, "administrator", "eland1234");
            sshClient.execCommand("cmd.exe /C start " + clonerCheckBatchPath);
        } catch (Exception e) {
            log.info(e.getMessage());
        }

    }

}
