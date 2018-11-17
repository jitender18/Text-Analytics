<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
String username=request.getParameter("username");
System.out.print(username);
String userpass=request.getParameter("userpass");
/* String branch=request.getParameter("branch"); */
boolean status=false;
try{
session.setAttribute("username",String.valueOf(username));
//session.setAttribute("user", username);
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
PreparedStatement ps=con.prepareStatement("select * from employee where email = ? and password = ? and emp_type = ?");
ps.setString(1,username);
ps.setString(2,userpass);
ps.setString(3, "Member");
/* ps.setString(3,branch); */
ResultSet rs=ps.executeQuery();
status=rs.next();
System.out.print(status);
if(status){
System.out.print("hi");
username=rs.getString(2);

session.setAttribute("islogin","plz sign in first");

%>
<jsp:forward page="assignCredit.jsp"></jsp:forward>
<%
}
else{
System.out.print("hi");
request.setAttribute("Error","Sorry! Username or Password Error. Plz Enter Correct Detail ");
session.setAttribute("Loginmsg","Plz sign in first");
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
}
}
catch(Exception e){
e.printStackTrace();
}

%>