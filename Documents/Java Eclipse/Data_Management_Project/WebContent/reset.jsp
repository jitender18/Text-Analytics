<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<html>
<body>

<%
String username=request.getParameter("username");
System.out.print(username);
String userpass=request.getParameter("userpass");
session.setAttribute("username",String.valueOf(username));
/* String branch=request.getParameter("branch"); */
boolean status=false;
try{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
PreparedStatement ps=con.prepareStatement("{call resetProc}");

ResultSet rs=ps.executeQuery();

}
catch(Exception e){
e.printStackTrace();
}
%>

<jsp:forward page="ahomepage.jsp"></jsp:forward>

</body>
</html>