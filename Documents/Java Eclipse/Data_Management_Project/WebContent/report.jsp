<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>


<div id="outer">
<jsp:include page="header.jsp"></jsp:include>


<%
String islogin=(String)session.getAttribute("islogin");
if(islogin==null){
request.setAttribute("notlogin_msg","Sorry,Please do Login first");
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
}
%>

<%
/* String n=request.getParameter("val"); */
String username=request.getParameter("username");
System.out.print(username);

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@MSB-MSITM.austin.utexas.edu:1521:ORCL","jl69799","Jitusql18");
	PreparedStatement ps=con.prepareStatement("select * from credits order by empid");
	PreparedStatement ps1=con.prepareStatement("select * from employee_details order by empid");
	/* ps.setString(1,username); */
	/* ps.setString(3,branch);*/
	ResultSet rs=ps.executeQuery();
	ResultSet rs1=ps1.executeQuery();
	out.print("<br>");	
	out.print("<table border='5' cellspacing=5 cellpadding=2>");
	out.print("<tr><td><B>ID</B></a></td><td><B>Name</B></td><td><B>Monthly Credits Left</B></td><td><B>Gift Credits</B></td><td><B>Gift Cards Bought</B></td></tr>");

while(rs.next() && rs1.next()){
	/* System.out.print("********** In while in home***********"); */
	out.print("<tr><td>"+rs.getString(1)+"</td>");
	out.print("<td>"+rs1.getString(2)+"</td>");
	out.print("<td>"+rs.getString(2)+"</td>");
	out.print("<td>"+rs.getString(3)+"</td>");
	out.print("<td>"+rs.getString(4)+"</td></tr>");
//out.print("<a href='#' name='"+rs.getString(1)+"' onmouseover='javascript:sendGenInfo(this.name)' ><font style='color: navy;'><B>General Information</B></font></a>");
}
out.print("</table>");
con.close();
}catch(Exception e){e.printStackTrace();}
//end of if
%>