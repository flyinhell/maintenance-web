<%@ page import="com.eland.dao.ViewClonerStatusDAO" %>
<%@ page import="com.eland.pojo.model.VwClonerStatusEntity" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/19
  Time: 下午 02:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>

<body>
<table class="table table-hover">
    <tbody class="topicTableContent">

    <th>機器名稱</th>
    <th>PID</th>
    <th>運作狀況</th>
    <th>更新時間</th>
    <th>上次任務完成時間</th>
    <th>任務間隔時間(min)</th>
    <th>複製任務狀況</th>
    <%
        ViewClonerStatusDAO viewClonerStatusDAO = new ViewClonerStatusDAO();
        List<VwClonerStatusEntity> taskLog = viewClonerStatusDAO.selectClonerStatus();
        for (VwClonerStatusEntity index : taskLog) {
            if ((index.getClonerMachine()).equals("FailQuery")) {
                System.out.println("this sql is exception.");
            }
    %>
    <tr>
        <td><%out.print(index.getClonerMachine());%></td>
        <td><%out.print(index.getPid());%></td>
        <td><%out.print(index.getProcessStatus());%></td>
        <td><%out.print(index.getUpdateTime());%></td>
        <td><%out.print(index.getLastFinishTaskTime());%></td>
        <td><%out.print(index.getMin());%></td>
        <td><%out.print(index.getStatus());%></td>
        <%--<td><input type="button" class="btn btn-info" value="關閉"></td>--%>
    </tr>
    <%
        }
    %>

    </tbody>
</table>

</body>
</html>
