package com.eland.backend;

import com.eland.dao.MachineTypeMappingDAO;
import com.eland.util.FileProperties;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;

public class CallSearchCommandBat {

    private static FileProperties properties = new FileProperties("OpviewMaintenance.properties");

    public void dopost(String type) {

        String killSearchCommandPath = properties.getProperty("killSearchCommandBatchPath");

        try {

            if(type.equals("selectStandard")){
                for(Map.Entry standard : MachineTypeMappingDAO.standard.entrySet()){
                    OpenSSHClient sshClient = new OpenSSHClient(standard.getValue().toString(), 22, "administrator", "eland1234");
                    sshClient.execCommand("cmd.exe /C start " + killSearchCommandPath);
                }
            }else if (type.equals("selectStaff")){
                for(Map.Entry staff : MachineTypeMappingDAO.staffOnly.entrySet()){
                    OpenSSHClient sshClient = new OpenSSHClient(staff.getValue().toString(), 22, "administrator", "eland1234");
                    sshClient.execCommand("cmd.exe /C start " + killSearchCommandPath);
                }
            }else if (type.equals("selectAdvanced")){
                for(Map.Entry advanced : MachineTypeMappingDAO.advanced.entrySet()){
                    OpenSSHClient sshClient = new OpenSSHClient(advanced.getValue().toString(), 22, "administrator", "eland1234");
                    sshClient.execCommand("cmd.exe /C start " + killSearchCommandPath);
                }
            }else if (type.equals("selectInstant")){
                for(Map.Entry instant : MachineTypeMappingDAO.staffOnly.entrySet()){
                    OpenSSHClient sshClient = new OpenSSHClient(instant.getValue().toString(), 22, "administrator", "eland1234");
                    sshClient.execCommand("cmd.exe /C start " + killSearchCommandPath);
                }
            }

        } catch (Exception e) {
            //  log.error("Exception: " + e.getMessage());
            System.out.println("Exception: " + e.getMessage());
        }

    }
}
