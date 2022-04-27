package com.eland.backend;

public class CallSearchInspectorBat {
    public void dopost(String type) {
        try {
            Runtime rt = Runtime.getRuntime();
            String cmdSearchInspector = "cmd /c start C:/intellij_project/OpviewServiceInspector/SearchInspector.bat";
            if (type.equals("SearchInspector")) {
                rt.exec(cmdSearchInspector);
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
        }
    }
}
