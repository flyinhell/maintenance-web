package com.eland.backend;

import ch.ethz.ssh2.ChannelCondition;
import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;
import ch.ethz.ssh2.StreamGobbler;
import org.apache.log4j.Logger;

import java.io.*;

public class OpenSSHClient {
    private static final Logger logger = Logger.getLogger(OpenSSHClient.class);

    private String ip;
    private int port;
    private String user;
    private String password;

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public OpenSSHClient(String ip, int port, String user, String password) {
        this.ip = ip;
        this.port = port;
        this.user = user;
        this.password = password;
    }

    public void execCommand(String command) {
        Connection connection = new Connection(ip, port);
        Session session = null;
        try {
            connection.connect();
            boolean isAuthenticated = connection.authenticateWithPassword(user, password);
            if (isAuthenticated == false) {
                logger.error("Authentication Failed");
            }
            session = connection.openSession();
            session.requestPTY("xterm");
            session.startShell();
            PrintWriter out = new PrintWriter(session.getStdin());
            out.println(command);
            out.flush();
            session.waitForCondition(ChannelCondition.CLOSED | ChannelCondition.EOF | ChannelCondition.EXIT_STATUS,
                    3000);
            logger.info("Finished executing command:" + command);

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    }

}
